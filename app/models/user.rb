class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :apartments, dependent: :destroy
  has_one_attached :avatar

  # Validations
  validates :fullname, presence: true, length: { minimum: 2, maximum: 50 }
  validates :phone, presence: true, 
    format: { with: /\A\+?[\d\s-]{10,}\z/, message: "must be a valid phone number" }
  validates :email, presence: true, 
    format: { with: URI::MailTo::EMAIL_REGEXP },
    uniqueness: { case_sensitive: false }
  validates :avatar, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
    size: { less_than: 2.megabytes }

  after_commit :add_default_avatar, on: %i[create update]

  private

  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join('app', 'assets', 'images', 'default.jpg')
        ),
        filename: 'default.jpg',
        content_type: 'image/jpg'
      )
    end
  end
end

