class LineItemsController < ApplicationController
  include CurrentCart

  skip_before_action :authorize, only: %i[show edit create update destroy]
  before_action :set_cart
  before_action :set_line_item, only: %i[show edit update destroy]

  # GET /line_items or /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1 or /line_items/1.json
  def show; end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit; end

  # POST /line_items or /line_items.json
  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to(store_index_url, locale: I18n.locale) }
        format.js do
          @current_item = @line_item
          render 'carts/update_cart'
        end
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1 or /line_items/1.json
  def update
    respond_to do |format|
      quantity = line_item_params[:quantity].to_i

      if quantity < 1
        @line_item.destroy!
        format.html { redirect_to(@cart, locale: I18n.locale, notice: 'Line item was successfully destroyed.') }
        format.json { head :no_content }
        format.js do
          @current_item = @line_item
          render 'carts/update_cart'
        end
      elsif @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
        format.js do
          @current_item = @line_item
          render 'carts/update_cart'
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1 or /line_items/1.json
  def destroy
    @line_item.destroy!
    respond_to do |format|
      format.html { redirect_to(@cart, locale: I18n.locale, notice: 'Line item was successfully destroyed.') }
      format.json { head :no_content }
      format.js { render 'carts/update_cart' }
    end
  end

  private

  def set_line_item
    @line_item = @cart.line_items.find(params[:id])
  end

  def line_item_params
    params.require(:line_item).permit(:quantity)
  end
end
