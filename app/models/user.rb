class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

    has_many :listings
    has_many :reservations

    has_attached_file :image, styles: { medium: "400x400>", thumb: "100x100>" }, default_url: "avater_default.png"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
       user.email = auth.info.email
       user.password = Devise.friendly_token[0,20]
       user.name = auth.info.name   # assuming the user model has a name

       # デフォルトのプロフィール画像が小さいので、大きい物をDBに入れるように修正
       # 【注意】auth.uidでfacebookのログインIDを取得する
       # user.image = auth.info.image
       user.image = "http://graph.facebook.com/#{auth.uid}/picture?type=large"
    end
  end

  def connected?
    !stripe_user_id.nil?
  end
end
