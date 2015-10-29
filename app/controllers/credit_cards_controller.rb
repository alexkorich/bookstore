class CreditCardsController < ApplicationController
  authorize_resource
  before_action :set_credit_card, only: [:show, :edit, :update, :destroy]
  # authorize_resource
  # GET /books
  # GET /books.json
  def index
    @credit_cards = CreditCard.where(user_id: current_user.id)
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @credit_card = CreditCard.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @credit_card = CreditCard.new(credit_card_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to :back, notice: 'Card was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { redirect_to :back, warning: 'An error occured.' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @credit_card.update(credit_card_params)
        format.html { redirect_to @credit_card, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @credit_card.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credit_card
      @credit_card = CreditCard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def credit_card_params
        params[:credit_card][:user_id]=current_user.id
        params.require(:credit_card).permit(:number, :user_id, :cvv, :book_id)
    end
end
