require 'spec_helper'

describe  "static page " do
  describe "home page" do
    it "should have the content 'sample app' " do
      visit '/static_page/home'
      expect(page).to have_content("sample app")
    end
  end
end
