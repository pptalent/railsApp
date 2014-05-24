class User < ActiveRecord::Base
  before_save do
    self.email=self.email.downcase
  end
  before_create do
    add_remember_token()
  end

  validates :name,presence:true,
                 length:{maximum:50}

  REGULAR_EXPRESSION=/[\w+\-.]+@[\w+\-]+.[a-z]+/i
  validates :email,presence:true,
                  format:{with:REGULAR_EXPRESSION},
                  uniqueness:{ case_sensitive:false  }

  has_secure_password
  validate :password,length:{minimum:1}

  def User.create_remember_token
    SecureRandom.urlsafe_base64
  end
  def User.digest_remember_token(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
  #这里之所以不是User.method是因为这个方法应该是针对User instance而非class的，否则self没法指向正确地对象
    def add_remember_token
      self.remember_token=User.digest_remember_token(User.create_remember_token)
    end

end
