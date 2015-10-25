require 'rails_helper'

RSpec.describe "wish_lists/show", type: :view do
  before(:each) do
    @wish_list = assign(:wish_list, WishList.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
