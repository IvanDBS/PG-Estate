class Apartment < ApplicationRecord
  belongs_to :user
  
  # CarrierWave uploader
  mount_uploaders :pictures, PictureUploader
  
  # Validations
  validates :bedroom, presence: true, numericality: { greater_than: 0 }
  validates :apt_type, presence: true
  validates :condition, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :location, presence: true
  validate :picture_size_validation
  
  # Enums
  enum condition: { excellent: 0, good: 1, fair: 2, needs_work: 3 }
  enum apt_type: { apartment: 0, house: 1, penthouse: 2 }
  
  # Scopes
  scope :latest, -> { order(created_at: :desc) }
  
  # Define which attributes can be searched using Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[bedroom apt_type condition price location created_at]
  end

  # Define which associations can be searched using Ransack
  def self.ransackable_associations(auth_object = nil)
    %w[user]
  end

  private
  
  def picture_size_validation
    errors[:pictures] << "should be less than 5MB" if pictures.any? { |pic| pic.size > 5.megabytes }
  end
end
