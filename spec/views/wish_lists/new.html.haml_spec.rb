require 'rails_helper'

RSpec.describe "wish_lists/new", type: :view do
  before(:each) do
    assign(:wish_list, WishList.new())
  end

  it "renders new wish_list form" do
    render

    assert_select "form[action=?][method=?]", wish_lists_path, "post" do
    end
  end
end
