class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :apartments

  has_one_attached :avatar

  after_commit :add_deafult_avatar, on: %i[create update]

  private

  def add_deafult_avatar 
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            'app', 'assets', 'images', 'deafult.jpg'
          )
        ), 
        filename: 'deafult.jpg',
        content_type: 'image/jpg'
      ) 
    end
  end
end

