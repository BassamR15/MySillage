# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_12_28_162317) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "vector"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.bigint "marketplace_profile_id", null: false
    t.string "label"
    t.string "address_line1"
    t.string "address_line2"
    t.string "city"
    t.string "postal_code"
    t.boolean "is_default"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "country"
    t.index ["marketplace_profile_id"], name: "index_addresses_on_marketplace_profile_id"
  end

  create_table "ai_conversations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "conversation_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_ai_conversations_on_user_id"
  end

  create_table "ai_messages", force: :cascade do |t|
    t.bigint "ai_conversation_id", null: false
    t.string "role"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ai_conversation_id"], name: "index_ai_messages_on_ai_conversation_id"
  end

  create_table "badges", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "condition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brand_collections", force: :cascade do |t|
    t.bigint "brand_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_brand_collections_on_brand_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "founded"
    t.string "logo_url"
  end

  create_table "collections", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "perfume_id", null: false
    t.integer "base_quantity_ml"
    t.float "quantity_ml"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["perfume_id"], name: "index_collections_on_perfume_id"
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer "buyer_id", null: false
    t.integer "seller_id", null: false
    t.bigint "listing_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_conversations_on_buyer_id"
    t.index ["listing_id"], name: "index_conversations_on_listing_id"
    t.index ["seller_id"], name: "index_conversations_on_seller_id"
  end

  create_table "disputes", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.integer "opened_by_id", null: false
    t.string "reason"
    t.text "description"
    t.string "status"
    t.string "resolution"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["opened_by_id"], name: "index_disputes_on_opened_by_id"
    t.index ["order_id"], name: "index_disputes_on_order_id"
  end

  create_table "favourites", force: :cascade do |t|
    t.bigint "marketplace_profile_id", null: false
    t.bigint "listing_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_favourites_on_listing_id"
    t.index ["marketplace_profile_id"], name: "index_favourites_on_marketplace_profile_id"
  end

  create_table "layerings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "base_perfume_id", null: false
    t.integer "top_perfume_id", null: false
    t.text "description"
    t.integer "upvote", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["base_perfume_id"], name: "index_layerings_on_base_perfume_id"
    t.index ["top_perfume_id"], name: "index_layerings_on_top_perfume_id"
    t.index ["user_id"], name: "index_layerings_on_user_id"
  end

  create_table "listings", force: :cascade do |t|
    t.bigint "marketplace_profile_id", null: false
    t.bigint "perfume_id", null: false
    t.integer "price_cents"
    t.float "quantity_ml"
    t.string "condition"
    t.text "description"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["marketplace_profile_id"], name: "index_listings_on_marketplace_profile_id"
    t.index ["perfume_id"], name: "index_listings_on_perfume_id"
  end

  create_table "marketplace_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "stripe_account_id"
    t.boolean "onboarding_complete"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_marketplace_profiles_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "conversation_id", null: false
    t.bigint "marketplace_profile_id", null: false
    t.text "content"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["marketplace_profile_id"], name: "index_messages_on_marketplace_profile_id"
  end

  create_table "notes", force: :cascade do |t|
    t.string "name"
    t.string "family"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "notification_type"
    t.string "notifiable_type", null: false
    t.bigint "notifiable_id", null: false
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "offer_items", force: :cascade do |t|
    t.bigint "offer_id", null: false
    t.bigint "listing_id"
    t.bigint "collection_id"
    t.float "quantity_ml"
    t.string "condition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id"], name: "index_offer_items_on_collection_id"
    t.index ["listing_id"], name: "index_offer_items_on_listing_id"
    t.index ["offer_id"], name: "index_offer_items_on_offer_id"
  end

  create_table "offers", force: :cascade do |t|
    t.bigint "conversation_id", null: false
    t.integer "sender_id", null: false
    t.integer "price_cents"
    t.string "status"
    t.text "ai_analyzed"
    t.datetime "analyzed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_offers_on_conversation_id"
    t.index ["sender_id"], name: "index_offers_on_sender_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "marketplace_profile_id", null: false
    t.bigint "listing_id", null: false
    t.string "status"
    t.integer "total_cents"
    t.string "stripe_payment_id"
    t.datetime "shipped_at"
    t.datetime "completed_at"
    t.bigint "perfume_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_orders_on_listing_id"
    t.index ["marketplace_profile_id"], name: "index_orders_on_marketplace_profile_id"
    t.index ["perfume_id"], name: "index_orders_on_perfume_id"
  end

  create_table "perfume_dupes", force: :cascade do |t|
    t.integer "original_perfume_id", null: false
    t.integer "dupe_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "similarity"
    t.index ["dupe_id"], name: "index_perfume_dupes_on_dupe_id"
    t.index ["original_perfume_id"], name: "index_perfume_dupes_on_original_perfume_id"
  end

  create_table "perfume_notes", force: :cascade do |t|
    t.bigint "perfume_id", null: false
    t.bigint "note_id", null: false
    t.string "note_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["note_id"], name: "index_perfume_notes_on_note_id"
    t.index ["perfume_id"], name: "index_perfume_notes_on_perfume_id"
  end

  create_table "perfume_perfumers", force: :cascade do |t|
    t.bigint "perfume_id", null: false
    t.bigint "perfumer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["perfume_id"], name: "index_perfume_perfumers_on_perfume_id"
    t.index ["perfumer_id"], name: "index_perfume_perfumers_on_perfumer_id"
  end

  create_table "perfumers", force: :cascade do |t|
    t.string "name"
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo_url"
  end

  create_table "perfumes", force: :cascade do |t|
    t.bigint "brand_id", null: false
    t.string "name"
    t.text "description"
    t.string "gender"
    t.integer "launch_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "discontinued", default: false
    t.integer "discontinued_year"
    t.boolean "reformulated", default: false
    t.integer "reformulation_year"
    t.vector "embedding", limit: 1536
    t.integer "price_cents"
    t.string "concentration"
    t.bigint "brand_collection_id", null: false
    t.index ["brand_collection_id"], name: "index_perfumes_on_brand_collection_id"
    t.index ["brand_id"], name: "index_perfumes_on_brand_id"
  end

  create_table "price_alerts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "perfume_id", null: false
    t.integer "max_price_cents"
    t.integer "min_quantity_ml"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["perfume_id"], name: "index_price_alerts_on_perfume_id"
    t.index ["user_id"], name: "index_price_alerts_on_user_id"
  end

  create_table "recommended_perfumes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "perfume_id", null: false
    t.float "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["perfume_id"], name: "index_recommended_perfumes_on_perfume_id"
    t.index ["user_id", "perfume_id"], name: "index_recommended_perfumes_on_user_id_and_perfume_id", unique: true
    t.index ["user_id"], name: "index_recommended_perfumes_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "perfume_id", null: false
    t.float "rating_overall"
    t.integer "rating_longevity"
    t.integer "rating_sillage"
    t.integer "rating_value"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["perfume_id"], name: "index_reviews_on_perfume_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "sale_records", force: :cascade do |t|
    t.bigint "perfume_id", null: false
    t.float "quantity_ml"
    t.integer "price_cents"
    t.datetime "sold_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["perfume_id"], name: "index_sale_records_on_perfume_id"
  end

  create_table "scent_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "preferred_longevity"
    t.string "preferred_intensity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_scent_profiles_on_user_id"
  end

  create_table "search_histories", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "query"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_search_histories_on_user_id"
  end

  create_table "season_votes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "perfume_id", null: false
    t.boolean "spring"
    t.boolean "summer"
    t.boolean "fall"
    t.boolean "winter"
    t.boolean "day"
    t.boolean "night"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["perfume_id"], name: "index_season_votes_on_perfume_id"
    t.index ["user_id"], name: "index_season_votes_on_user_id"
  end

  create_table "seller_reviews", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "marketplace_profile_id", null: false
    t.text "content"
    t.float "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["marketplace_profile_id"], name: "index_seller_reviews_on_marketplace_profile_id"
    t.index ["order_id"], name: "index_seller_reviews_on_order_id"
  end

  create_table "smells", force: :cascade do |t|
    t.bigint "scent_profile_id", null: false
    t.bigint "note_id", null: false
    t.string "preference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["note_id"], name: "index_smells_on_note_id"
    t.index ["scent_profile_id"], name: "index_smells_on_scent_profile_id"
  end

  create_table "user_badges", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "badge_id", null: false
    t.datetime "earned_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["badge_id"], name: "index_user_badges_on_badge_id"
    t.index ["user_id"], name: "index_user_badges_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.text "bio"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "verifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "perfume_id", null: false
    t.string "code"
    t.date "production_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["perfume_id"], name: "index_verifications_on_perfume_id"
    t.index ["user_id"], name: "index_verifications_on_user_id"
  end

  create_table "wishlists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "perfume_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["perfume_id"], name: "index_wishlists_on_perfume_id"
    t.index ["user_id"], name: "index_wishlists_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "marketplace_profiles"
  add_foreign_key "ai_conversations", "users"
  add_foreign_key "ai_messages", "ai_conversations"
  add_foreign_key "brand_collections", "brands"
  add_foreign_key "collections", "perfumes"
  add_foreign_key "collections", "users"
  add_foreign_key "conversations", "listings"
  add_foreign_key "conversations", "marketplace_profiles", column: "buyer_id"
  add_foreign_key "conversations", "marketplace_profiles", column: "seller_id"
  add_foreign_key "disputes", "marketplace_profiles", column: "opened_by_id"
  add_foreign_key "disputes", "orders"
  add_foreign_key "favourites", "listings"
  add_foreign_key "favourites", "marketplace_profiles"
  add_foreign_key "layerings", "perfumes", column: "base_perfume_id"
  add_foreign_key "layerings", "perfumes", column: "top_perfume_id"
  add_foreign_key "layerings", "users"
  add_foreign_key "listings", "marketplace_profiles"
  add_foreign_key "listings", "perfumes"
  add_foreign_key "marketplace_profiles", "users"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "marketplace_profiles"
  add_foreign_key "notifications", "users"
  add_foreign_key "offer_items", "collections"
  add_foreign_key "offer_items", "listings"
  add_foreign_key "offer_items", "offers"
  add_foreign_key "offers", "conversations"
  add_foreign_key "offers", "marketplace_profiles", column: "sender_id"
  add_foreign_key "orders", "listings"
  add_foreign_key "orders", "marketplace_profiles"
  add_foreign_key "orders", "perfumes"
  add_foreign_key "perfume_dupes", "perfumes", column: "dupe_id"
  add_foreign_key "perfume_dupes", "perfumes", column: "original_perfume_id"
  add_foreign_key "perfume_notes", "notes"
  add_foreign_key "perfume_notes", "perfumes"
  add_foreign_key "perfume_perfumers", "perfumers"
  add_foreign_key "perfume_perfumers", "perfumes"
  add_foreign_key "perfumes", "brand_collections"
  add_foreign_key "perfumes", "brands"
  add_foreign_key "price_alerts", "perfumes"
  add_foreign_key "price_alerts", "users"
  add_foreign_key "recommended_perfumes", "perfumes"
  add_foreign_key "recommended_perfumes", "users"
  add_foreign_key "reviews", "perfumes"
  add_foreign_key "reviews", "users"
  add_foreign_key "sale_records", "perfumes"
  add_foreign_key "scent_profiles", "users"
  add_foreign_key "search_histories", "users"
  add_foreign_key "season_votes", "perfumes"
  add_foreign_key "season_votes", "users"
  add_foreign_key "seller_reviews", "marketplace_profiles"
  add_foreign_key "seller_reviews", "orders"
  add_foreign_key "smells", "notes"
  add_foreign_key "smells", "scent_profiles"
  add_foreign_key "user_badges", "badges"
  add_foreign_key "user_badges", "users"
  add_foreign_key "verifications", "perfumes"
  add_foreign_key "verifications", "users"
  add_foreign_key "wishlists", "perfumes"
  add_foreign_key "wishlists", "users"
end
