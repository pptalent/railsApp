class Comment < ActiveRecord::Base
  belongs_to :micropost
  belongs_to :user
  default_scope -> { order("created_at DESC")}
  validates :micropost_id,presence:true
  validates :content,presence:true,
                    length:{minimum:1,maximum:140}
end
