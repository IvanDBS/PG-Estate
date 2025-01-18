class Apartment < ApplicationRecord
  belongs_to :user
  has_many_attached :pictures
  
  # Validations
  validates :bedroom, :apt_type, :condition, :price, :location, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :pictures, presence: true, 
    content_type: ['image/png', 'image/jpg', 'image/jpeg'],
    size: { less_than: 5.megabytes }
    
  # Enums for better data consistency
  enum condition: {
    excellent: 'excellent',
    good: 'good',
    fair: 'fair',
    needs_work: 'needs_work'
  }
  
  enum apt_type: {
    apartment: 'apartment',
    house: 'house',
    studio: 'studio',
    penthouse: 'penthouse'
  }
  
  # Scopes for common queries
  scope :by_price_range, ->(min, max) { where(price: min..max) }
  scope :by_type, ->(type) { where(apt_type: type) }
  scope :by_condition, ->(condition) { where(condition: condition) }
  scope :recent, -> { order(created_at: :desc) }
end
