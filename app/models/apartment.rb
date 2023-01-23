class Apartment < ApplicationRecord
  belongs_to :user
  has_many_attached :pictures

  validates :price, :apt_type, :badroom, :condition, :location, :pictures, presence: :true
end
