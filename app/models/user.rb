class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :apartments, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  # Validations
  validates :fullname,
            presence: true,
            length: { minimum: 2, maximum: 50 }

  validates :phone,
            presence: true,
            format: { with: /\A\+?[\d\s-]{10,}\z/ }

  validates :email,
            presence: true,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            uniqueness: { case_sensitive: false }

  validate :avatar_size_validation

  private

  def avatar_size_validation
    if avatar.size > 2.megabytes
      errors[:avatar] << "should be less than 2MB"
    end
  end
end
