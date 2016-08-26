class Tag < ApplicationRecord
  belongs_to :entity, polymorphic: true
end
