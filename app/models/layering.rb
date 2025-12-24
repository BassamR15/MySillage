class Layering < ApplicationRecord
  belongs_to :user
  belongs_to :base_perfume_id, class_name: "Perfume"
  belongs_to :top_perfume_id, class_name: "Perfume"
end
