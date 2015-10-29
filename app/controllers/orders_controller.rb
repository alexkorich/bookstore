class OrdersController < ApplicationController
  authorize_resource
  before_action :set_order, only: [:show, :edit, :update, :destroy, :promocode]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json

  def promocode
    a=params[:code][:code]
    if a
      if @order.gift_code(a)==true
      respond_to do |format|
        format.html { redirect_to :back, notice: 'Cart updated!.' }
        format.json { render json: {id:  @order_item.id, price: current_user.current_order.total_price, quantity: current_user.current_order.order_items.inject(0){|sum, item| sum+=item.quantity}}}
      end  
     else
      respond_to do |format|
       format.html {  redirect_to :back, notice: @order.gift_code(a) }
       format.json { render json: @order.errors, status: :unprocessable_entity }
     end
    end
    end
  end
    def add_to_cart
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




  
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params[:order]
    end
end
