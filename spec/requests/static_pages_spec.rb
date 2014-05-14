require 'spec_helper'

describe  "static page " do
  describe "home page" do
    before {visit root_path}
    subject {page}
    it {should have_content('Wayne')}
    it {should have_title(full_title(""))}
  end
end
