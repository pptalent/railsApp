require 'spec_helper'

describe "AuthenticatePages" do

  describe "sign in before edit" do
    let(:user){FactoryGirl.create(:user)}
    subject{page}
    describe "patch response" do
      before {patch user_path(user)}
      specify {expect(response).to redirect_to(login_path)}
    end
  end

  describe "wrong user log in" do
    let(:user){FactoryGirl.create(:user)}
    let(:wrong_user){FactoryGirl.create(:user,email:"wrong@sina.com")}
    before { sign_in user}

    describe  "submit get to edit page" do
      before { get edit_user_path(wrong_user) }
      specify { expect(response).to redirect_to(root_url) }
    end

    describe "patch wrong user" do
      before { patch user_path(wrong_user)}
      specify { expect(response).to redirect_to(root_url) }
    end
  end

  describe "show all users" do
    describe "you should login in first" do
      before {get users_path}
      it { expect(response).to redirect_to(login_path) }
    end
  end

end
