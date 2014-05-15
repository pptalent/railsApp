require 'spec_helper'

describe User do
  before {@user=User.new(name:"wayne",email:"superxiao21@163.com",password:"wangzixiao",password_confirmation:"wangzixiao")}
  subject {@user}
  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:password_digest)}
  it {should respond_to(:authenticate)}

  describe "validate email" do
    it "should validate various kind of format" do
      address=%w[white_btt@hotmail.com superxiao21@sina.com zixiao.wang@hotmail.com]
      address.each do |i|
        @user.email=i
        expect(@user).to be_valid
      end
    end
  end

  describe "validate user" do
    before do
        @user.name="wangzixiao19900821"
        @user.email="superxiao21@sina.com"
        @wayne=@user.dup
        @wayne.email=@user.email.upcase
        @wayne.save
    end
    it { should_not be_valid}
  end

  describe "validate password" do
    before {@user.save}
    let(:find_user){User.find_by(email:@user.email)}
    describe "after find email validate the password" do
      specify { should eq find_user.authenticate(@user.password) }
    end
  end

end
