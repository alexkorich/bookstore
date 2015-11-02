class OrderItemsController < ApplicationController
  authorize_resource
  before_action :set_order_item, only: [:show, :edit, :update, :destroy]

  def index
    @order=current_user.current_order
    @order_items=OrderItem.where(order_id: current_user.current_order.id)
  end


  def update
    if request["order_item"]["quantity"].to_i==0
      OrderItem.destroy(request["id"])
    end
   respond_to do |format|
      if @order_item.update(order_items_params)
        format.html { redirect_to :back, notice: 'Order item was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { redirect_to :back, notice: @order_item.errors.full_messages}
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end


  def empty
     @order=current_user.current_order
    if @order.order_items
      @order.order_items.destroy_all
    end
    respond_to do |format|
      if @order.save
        format.html { redirect_to :back, notice: 'Order item was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end
  

  def destroy
   @order_item.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Item was successfully destroyed.' }
      format.json { render json: {id:  @order_item.id, price: current_user.current_order.total_price, quantity: current_user.current_order.order_items.inject(0){|sum, item| sum+=item.quantity}}}
    end
  end

   private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end
    def order_items_params
      params.require(:order_item).permit(:quantity)
    end

end
