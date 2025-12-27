# app/controllers/api/search_controller.rb
class Api::SearchController < ApplicationController
  skip_before_action :authenticate_user!

  def search
    query = params[:q].to_s.strip.downcase

    return render json: {} if query.length < 2

    perfumes = Perfume.where("name ILIKE ?", "%#{query}%")
                      .includes(:brand)
                      .limit(8)
                      .map { |p| { id: p.id, name: p.name, brand: p.brand.name, placeholder_image: p.placeholder_image } }

    brands = Brand.where("name ILIKE ?", "%#{query}%")
                  .limit(8)
                  .map { |b| { id: b.id, name: b.name, count: b.perfumes.count, logo: b.logo_url } }

    notes = Note.where("name ILIKE ?", "%#{query}%")
                .limit(5)
                .map { |n| { id: n.id, name: n.name, family: n.family, image: n.image_url } }

    perfumers = Perfumer.where("name ILIKE ?", "%#{query}%")
                        .limit(3)
                        .map { |p| { id: p.id, name: p.name, count: p.perfumes.count, photo: p.photo_url } }

    render json: {
      perfumes: perfumes,
      brands: brands,
      notes: notes,
      perfumers: perfumers
    }
  end
end
