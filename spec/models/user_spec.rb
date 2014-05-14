require 'spec_helper'

describe User do
  before {@user=User.new(name:"wayne",email:"")}
  subject {@user}
  it {should respond_to(:name)}
  it {should respond_to(:email)}

  describe "validate email" do
    it "should validate various kind of format" do
      address=%w[white_btt@hotmail.com superxiao21@sina.com zixiao.wang@hotmail.com]
      address.each do |i|
        @user.email=i
        expect(@user).to be_valid
      end
    end
  end
end
