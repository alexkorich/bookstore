require 'rails_helper'

RSpec.describe "wish_lists/edit", type: :view do
  before(:each) do
    @wish_list = assign(:wish_list, WishList.create!())
  end

  it "renders the edit wish_list form" do
    render

    assert_select "form[action=?][method=?]", wish_list_path(@wish_list), "post" do
    end
  end
end
