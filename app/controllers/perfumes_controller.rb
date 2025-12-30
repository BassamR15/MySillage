class PerfumesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]
  def index
    @perfumes_base = Perfume.sorted_by(params[:order])
    
    if params[:search].present?
      sql_subquery = <<~SQL
        perfumes.name ILIKE :query
        OR brands.name ILIKE :query
        OR notes.name ILIKE :query
        OR notes.family ILIKE :query
      SQL
      @perfumes_base = @perfumes_base.joins(:brand, :notes).where(sql_subquery, query: "%#{params[:search]}%").distinct
    end

    if params[:brands].present?
      @perfumes_base = @perfumes_base.where(brand_id: params[:brands])
    end

    if params[:genders].present?
      genders = params[:genders]
      if genders.include?('male') || genders.include?('female')
        genders = genders + ['unisex'] unless genders.include?('unisex')
      end
      @perfumes_base = @perfumes_base.where(gender: genders.uniq)
    end

    if params[:families].present?
      @perfumes_base = @perfumes_base.joins(:notes).where(notes: { family: params[:families] }).distinct
    end

    total_count = @perfumes_base.count
    @perfumes = @perfumes_base.limit(24).offset(params[:offset].to_i || 0)

    wishlisted_ids = user_signed_in? ? current_user.wishlists.pluck(:perfume_id) : []
    price_alerted_ids = user_signed_in? ? current_user.price_alerts.pluck(:perfume_id) : []

    perfumes_json = @perfumes.map { |perfume|
      perfume.as_json(include: {
        brand: { only: [:id, :name] },
        notes: { only: [:name, :family] }
      }).merge(
        placeholder_image: perfume.placeholder_image,
        wishlisted: wishlisted_ids.include?(perfume.id),
        price_alerted: price_alerted_ids.include?(perfume.id),
        average: perfume.average_overall
      )
    }

    if request.format.json?
      render json: { perfumes: perfumes_json, totalCount: total_count }
    else
      render inertia: 'Perfumes/Index', props: {
        perfumes: perfumes_json,
        totalCount: total_count,
        brands: Brand.all.as_json(only: [:id, :name]),
        families: Note.distinct.pluck(:family),
        userSignedIn: user_signed_in?,
        currentUser: user_signed_in? ? current_user.as_json(only: [:id, :email, :username]) : nil,
        currentOrder: params[:order] || '',
        currentSearch: params[:search] || '',
        currentFilters: {
          brands: (params[:brands] || []).map(&:to_i).uniq,
          genders: params[:genders] || [],
          families: params[:families] || []
        },
        sidebarOpen: params[:sidebar] == 'true'
      }
    end
  end

  def show
    @perfume = Perfume.find(params[:id])
    PerfumeVisit.create(perfume: @perfume)

    render inertia: 'Perfumes/Show', props: {
      perfume: {
        **@perfume.as_json(include: {
          brand: { only: [:name] },
          perfumers: { only: [:name] },
          notes: { only: [:name, :family] },
          perfume_notes: { only: [:note_type] }
        }),
        placeholder_image: @perfume.placeholder_image,
        notes_ordered: @perfume.notes_ordered,
        preferred_time: @perfume.preferred_time,
        preferred_season: @perfume.preferred_season,
        longevity_distribution: @perfume.rating_distribution(:rating_longevity),
        sillage_distribution: @perfume.rating_distribution(:rating_sillage),
        value_distribution: @perfume.rating_distribution(:rating_value)
      },
      userSignedIn: user_signed_in?,
      currentUser: user_signed_in? ? current_user.as_json(only: [:id, :email, :username]) : nil,
      userSeasonVotes: user_signed_in? ? @perfume.season_votes.find_by(user: current_user) : nil,
      userReviews: user_signed_in? ? @perfume.reviews.find_by(user: current_user) : nil,
      userWishlist: user_signed_in? ? Wishlist.exists?(user: current_user, perfume: @perfume) : false,
      userCollectedVolumes: user_signed_in? ? @perfume.collections.where(user: current_user).pluck(:base_quantity_ml) : [],
      userPriceAlert: user_signed_in? ? @perfume.price_alerts.find_by(user: current_user) : nil
    }
  end
end
