class Micropost < ActiveRecord::Base
  belongs_to :user
  has_many :comments,:dependent=> :destroy
  default_scope -> { order("created_at DESC") }
  validates :user_id,:presence=> true
  validates :content,:presence=>true,
            :length=>{:maximum=>140,:minimum=>1}

  def Micropost.get_post_from_followed(user)
     #followed_user_ids=user.followed_user.map(&:id)
     #where("user_id IN (?) OR user_id = ?",followed_user_ids,user)
     #为了提高效率，交由数据库来处理

      followed_user_ids="SELECT followed_id FROM relationships WHERE follower_id=:user_id"
      Micropost.where("user_id IN (#{followed_user_ids}) OR user_id=:user_id",:user_id=>user.id)
  end

end
