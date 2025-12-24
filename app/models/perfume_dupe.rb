class PerfumeDupe < ApplicationRecord
  belongs_to :original_perfume, class_name: "Perfume"

  belongs_to :dupe, class_name: "Perfume"
end
