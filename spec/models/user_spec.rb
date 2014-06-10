require 'spec_helper'

describe User do
  before {@user=User.new(name:"wayne",email:"superxiao21@163.com",password:"wangzixiao",password_confirmation:"wangzixiao")}
  subject {@user}
  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:password_digest)}
  it {should respond_to(:authenticate)}
  it {should respond_to(:remember_token)}

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

  describe "remember token" do
    before{@user.save}
    its(:remember_token){should_not be_blank}
  end

  describe "micropost" do
    describe "micropost got desc order" do
      before{@user.save}
      let!(:older_twitter){FactoryGirl.create(:microposts,user:@user,created_at:1.day.ago)}
      let!(:new_twitter){FactoryGirl.create(:microposts,user:@user,created_at:1.hour.ago)}
      it{expect(@user.microposts.to_a).to eq [new_twitter,older_twitter]}
      it "delete user and its microposts" do
        microposts=@user.microposts.to_a
        @user.destroy
        expect(microposts).not_to be_empty
        microposts.each do |micropost|
          expect(Micropost.where(micropost.id)).to be_empty
        end
      end
    end
  end

end
