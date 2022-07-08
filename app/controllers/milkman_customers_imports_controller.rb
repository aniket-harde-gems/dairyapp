class MilkmanCustomersImportsController < ApplicationController
  def new
    @milkman_customers_import = MilkmanCustomersImport.new
  end

  def create
    @milkman_customers_import = MilkmanCustomersImport.new(params[:milkman_customers_import])
    if @milkman_customers_import.save
      redirect_to milkmen_path
    else
      render :new
    end
    
  end


end
