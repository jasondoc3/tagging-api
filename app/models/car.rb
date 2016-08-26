class Car < ApplicationRecord
  has_many :tags, as: :entity
end
