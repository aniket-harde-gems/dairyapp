class MilkmanProductsController < ApplicationController
  before_action :set_milkman_product, only: %i[ show edit update destroy ]

  # GET /milkman_products or /milkman_products.json
  def index
    @milkman_products = MilkmanProduct.all
  end

  # GET /milkman_products/1 or /milkman_products/1.json
  def show
  end

  # GET /milkman_products/new
  def new
    @milkman_product = MilkmanProduct.new
  end

  # GET /milkman_products/1/edit
  def edit
  end

  # POST /milkman_products or /milkman_products.json
  def create
    @milkman_product = MilkmanProduct.new(milkman_product_params)

    respond_to do |format|
      if @milkman_product.save
        format.html { redirect_to milkman_product_url(@milkman_product), notice: "Milkman product was successfully created." }
        format.json { render :show, status: :created, location: @milkman_product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @milkman_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /milkman_products/1 or /milkman_products/1.json
  def update
    respond_to do |format|
      if @milkman_product.update(milkman_product_params)
        format.html { redirect_to milkman_product_url(@milkman_product), notice: "Milkman product was successfully updated." }
        format.json { render :show, status: :ok, location: @milkman_product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @milkman_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /milkman_products/1 or /milkman_products/1.json
  def destroy
    @milkman_product.destroy

    respond_to do |format|
      format.html { redirect_to milkman_products_url, notice: "Milkman product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_milkman_product
      @milkman_product = MilkmanProduct.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def milkman_product_params
      params.require(:milkman_product).permit(:product_name, :product_price, :milkman_id)
    end
end
