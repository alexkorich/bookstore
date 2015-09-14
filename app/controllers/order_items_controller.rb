class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:show, :edit, :update, :destroy]

  def index
    @order_items=OrderItem.where(order_id: current_user.current_order.id)
  end
  def update
     respond_to do |format|
      if @order_item.update(order_items_params)
        format.html { redirect_to :back, notice: 'Order item was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
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