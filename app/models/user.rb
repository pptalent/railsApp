class User < ActiveRecord::Base
  validates :name,presence:true,
                 length:{maximum:50}
  REGULAR_EXPRESSION=/[\w+\-.]+@[\w+\-]+.[a-z]+/i
  validates :email,presence:true,
                  format:{with:REGULAR_EXPRESSION}
end
