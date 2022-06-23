class MilkmanCustomersController < ApplicationController
  before_action :set_milkman_customer, only: %i[ show edit update destroy ]

  # GET /milkman_customers or /milkman_customers.json
  def index
    @milkman_customers = MilkmanCustomer.all
  end

  # GET /milkman_customers/1 or /milkman_customers/1.json
  def show
  end

  # GET /milkman_customers/new
  def new
    @milkman_customer = MilkmanCustomer.new
  end

  # GET /milkman_customers/1/edit
  def edit
  end

  # POST /milkman_customers or /milkman_customers.json
  def create
    @milkman_customer = MilkmanCustomer.new(milkman_customer_params)

    respond_to do |format|
      if @milkman_customer.save
        format.html { redirect_to milkman_customer_url(@milkman_customer), notice: "Milkman customer was successfully created." }
        format.json { render :show, status: :created, location: @milkman_customer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @milkman_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /milkman_customers/1 or /milkman_customers/1.json
  def update
    respond_to do |format|
      if @milkman_customer.update(milkman_customer_params)
        format.html { redirect_to milkman_customer_url(@milkman_customer), notice: "Milkman customer was successfully updated." }
        format.json { render :show, status: :ok, location: @milkman_customer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @milkman_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /milkman_customers/1 or /milkman_customers/1.json
  def destroy
    @milkman_customer.destroy

    respond_to do |format|
      format.html { redirect_to milkman_customers_url, notice: "Milkman customer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_milkman_customer
      @milkman_customer = MilkmanCustomer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def milkman_customer_params
      params.require(:milkman_customer).permit(:customer_name, :customer_address, :customer_mobile_number, :milkman_id)
    end
end
