class HomeController < ApplicationController

  def index
  	
  end

    def bestsellers
    Book.all.limit(5)
    end
    def add_to_cart
    authorize! :add_to_cart, Book, message: "You must log in to perform this action"
    puts "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT"
    cart=current_user.current_order
    cart.add_book(Book.find(params[:book][:id]), params[:book][:quantity].to_i)
    respond_to do |format|
      if cart.save
        format.html { redirect_to :back, notice: 'Book added!' }
        format.json {render json: {"price" => cart.total_price, "quantity" => cart.order_items.inject(0){|sum, item| sum+=item.quantity}}}
      else
        format.html { redirect_to :back, notice: 'NONONON' }
        format.json {render :json => cart.errors, :status => :unprocessable_entity}
      end
    end
  end 
end
