require 'rails_helper'

RSpec.describe "wish_lists/index", type: :view do
  before(:each) do
    assign(:wish_lists, [
      WishList.create!(),
      WishList.create!()
    ])
  end

  it "renders a list of wish_lists" do
    render
  end
end
