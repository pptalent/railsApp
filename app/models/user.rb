class User < ActiveRecord::Base
  before_save do
    self.email=self.email.downcase
  end
  before_create do
    add_remember_token()
  end
  has_many :microposts,:dependent=>:destroy
  has_many :comments

  has_many :relationships,:foreign_key=>"follower_id",
                          :dependent=>:destroy
  has_many :followed_user,:through=>:relationships,:source=>:followed

  has_many :reverse_relationships,:foreign_key=>"followed_id",
                                  :class_name=>"Relationship",
                                  :dependent=>:destroy
  has_many :follower_user,:through=>:reverse_relationships,:source=>:follower


  validates :name,:presence=>true,
                 :length=>{:maximum=>50}

  REGULAR_EXPRESSION=/[\w+\-.]+@[\w+\-]+.[a-z]+/i
  validates :email,presence:true,
                  :format=>{:with=>REGULAR_EXPRESSION},
                  :uniqueness=>{ :case_sensitive=>false  }

  has_secure_password
  validates :password,:length=>{:minimum=>1}

  def User.create_remember_token
    SecureRandom.urlsafe_base64
  end
  def User.digest_remember_token(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  def feed
      Micropost.get_post_from_followed(self)
  end

  def following?(sb_user)
    self.relationships.find_by(followed_id:sb_user.id)
  end
  def followed!(sb_user)
    self.relationships.create!(followed_id:sb_user.id)
  end
  def unfollow!(sb_user)
    self.relationships.find_by(followed_id:sb_user.id).destroy
  end


  private
  #这里之所以不是User.method是因为这个方法应该是针对User instance而非class的，否则self没法指向正确地对象
    def add_remember_token
      self.remember_token=User.digest_remember_token(User.create_remember_token)
    end

end
