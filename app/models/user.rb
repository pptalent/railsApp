class User < ActiveRecord::Base
  before_save do
    self.email=self.email.downcase
  end

  validates :name,presence:true,
                 length:{maximum:50}

  REGULAR_EXPRESSION=/[\w+\-.]+@[\w+\-]+.[a-z]+/i
  validates :email,presence:true,
                  format:{with:REGULAR_EXPRESSION},
                  uniqueness:{ case_sensitive:false  }

  has_secure_password
  validate :password,length:{minimum:1}
end
