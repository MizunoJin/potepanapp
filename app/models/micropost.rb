class Micropost < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :comments, dependent: :destroy
  has_many :users, through: :likes
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :image,   content_type: { in: %w[image/jpeg image/png],
                                      message: "有効なフォーマットではありません" },
                      size:         { less_than: 5.megabytes,
                                      message: "ファイルサイズが大きすぎます" },
                                      presence: true
  
   # ある投稿がいいね済みか調べる
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
