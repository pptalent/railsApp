require 'spec_helper'

describe Micropost do
  let(:user){FactoryGirl.create(:user)}
  before {@micropost=user.microposts.build(content:"first content")}
  subject{@micropost}
  it { should respond_to(:content)}
  it { should respond_to(:user_id)}
  it { should respond_to(:user)}
  its(:user){should eq user}

  describe "micropost no user" do
    before { @micropost.user=nil}
    it{should_not be_valid}
  end

  describe "micropost shouldn't have too much content" do
    before{@micropost.content="a"*150}
    it{should_not be_valid}
  end
  describe "micropost shouldn't have empty content" do
    before{@micropost.content="  "}
    it{should_not be_valid}
  end
end
