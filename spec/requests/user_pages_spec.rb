require 'spec_helper'

describe "UserPage" do
  subject {page}

  describe "profile" do
   let(:user){FactoryGirl.create(:user)}
   before { visit user_path(user) }

    it {should have_content(user.name)}
    it {should have_content(user.email)}
  end

  describe "sign up" do
    before {visit signup_path}
    describe "fill validate info to sign up" do
      before do
        fill_in "user_name",with:"wangzixiao"
        fill_in "user_email",with:"superxiao21@sina.com"
        fill_in "user_password",with:"wangzixiao"
        fill_in "user_password_confirmation",with:"wangzixiao"
      end
      it "should create a user" do
        expect {click_button "Ready to go !"}.to change(User,:count).by(1)
      end
    end
  end





end
