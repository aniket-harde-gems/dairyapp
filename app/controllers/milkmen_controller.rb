class MilkmenController < ApplicationController
  before_action :set_milkman, only: %i[ show edit update destroy ]

  # GET /milkmen or /milkmen.json
  def index
    @milkmen = Milkman.all
    @milkman_products = MilkmanProduct.all
    respond_to do |format|
      format.xlsx {
        response.headers[
          'Content-Disposition'
        ] = "attachment; filename= customer.xlsx"
      }
      format.html { render :index }
    end
  end

  # GET /milkmen/1 or /milkmen/1.json
  def show
  end

  # GET /milkmen/new
  def new
    @milkman = Milkman.new
  end

  # GET /milkmen/1/edit
  def edit
  end

  # POST /milkmen or /milkmen.json
  def create
    @milkman = Milkman.new(milkman_params)

    respond_to do |format|
      if @milkman.save
        format.html { redirect_to milkman_url(@milkman), notice: "Milkman was successfully created." }
        format.json { render :show, status: :created, location: @milkman }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @milkman.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /milkmen/1 or /milkmen/1.json
  def update
    respond_to do |format|
      if @milkman.update(milkman_params)
        format.html { redirect_to milkman_url(@milkman), notice: "Milkman was successfully updated." }
        format.json { render :show, status: :ok, location: @milkman }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @milkman.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /milkmen/1 or /milkmen/1.json
  def destroy
    @milkman.destroy

    respond_to do |format|
      format.html { redirect_to milkmen_url, notice: "Milkman was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_milkman
      @milkman = Milkman.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def milkman_params
      params.require(:milkman).permit(:name)
    end
end
