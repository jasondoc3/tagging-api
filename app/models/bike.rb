class Bike < ApplicationRecord
  has_many :tags, as: :entity
end
