class MilkmanCustomersImport
	include ActiveModel::Model
	require 'roo'

	attr_accessor :file

	def initialize(attributes={})
    attributes.each { |name, value| send("#{name}=", value) }
  end

	def persisted?
    false
  end

	def open_spreadsheet
    case File.extname(file.original_filename)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def get_orignal_header
    header = ["Customer Name", "Customer Address", "Customer Mobile Number"]
    MilkmanProduct.all.to_a.each do |product|
      morning = product.product_name + " (Morning) Quantity" 
      evening = product.product_name + " (Evening) Quantity"
      header << morning
      header << evening
    end
    header
  end

  def is_header_valid(header)
    orignal_header = get_orignal_header
    imported_header = header
    orignal_header == imported_header
  end

	def save_imported_records
    return_value = true
    ActiveRecord::Base.transaction do
      spreadsheet = open_spreadsheet
      header = spreadsheet.row(1)
      if !is_header_valid(header)
        errors.add :base, "Invalid header"
        return false
      end

      #Extracting product names and their shifts 
      product_names = []
      shifts = []
      header.each_with_index do | h, id|
        if id >= 3
          splited_header_array = h.split(" (", 2)
          product_names << splited_header_array[0]
          shifts << splited_header_array[1].split( ") ", 2)[0] 
        end
      end

      product_names.uniq!
      shifts.uniq!
      
      (2..spreadsheet.last_row).map do |i|

        #Finding milkman via milkmam product
        milkman_product = MilkmanProduct.find_by(product_name: product_names[0])
        milkman = milkman_product.milkman

        #Saving Milkman Customer
        header_for_customer = [ "customer_name" , "customer_address" , "customer_mobile_number" , "milkman_id" ]
        row_for_customer = []
        values_of_product_quantity = []
        spreadsheet.row(i).each_with_index do |data, idx|
          if idx <= 2
            row_for_customer << data
          elsif idx > 2
            values_of_product_quantity << data
          end
        end

        row_for_customer << milkman.id
        hash_for_customer = Hash[[header_for_customer, row_for_customer].transpose]
        milkman_customer = MilkmanCustomer.new
        milkman_customer.attributes = hash_for_customer.to_hash
        if milkman_customer.valid?
          if values_of_product_quantity.any? { |v| !v.nil?} #checking if array containes any valid value
            milkman_customer.save
          end
        else
          milkman_customer.errors.full_messages.each do |msg|
            errors.add :base, "Row #{i} can't save customer because: #{msg}"
          end
          return_value = false
        end

        #Saving Milkman Customer Delivery Preference
        if !milkman_customer.errors.present?
          header_for_customer_delivery_preference = [ "milkman_customer_id", "milkman_product_id", "shift", "quantity"]
          col_id = 3
          product_names.each do | p_name |
            milkman_product = MilkmanProduct.find_by(product_name: p_name)
            shifts.each do |shift|
              row_for_customer_delivery_preference = [milkman_customer.id, milkman_product.id]
              if shift === "Evening"
                row_for_customer_delivery_preference << "e"
              elsif shift === "Morning"
                row_for_customer_delivery_preference << "m"
              end

              row_for_customer_delivery_preference << spreadsheet.row(i)[col_id]

              hash_for_delivery_preference = Hash[[header_for_customer_delivery_preference, row_for_customer_delivery_preference].transpose]
              customer_delivery_preference = CustomerDeliveryPreference.new
              customer_delivery_preference.attributes = hash_for_delivery_preference.to_hash
              if customer_delivery_preference.valid?
                customer_delivery_preference.save
                col_id += 1
              else
                customer_delivery_preference.errors.full_messages.each do |msg|
                  errors.add :base, "Row #{i} can't save customer delivery preference because: #{msg}"
                end
                return_value = false
              end
            end
          end
        end
      
      end
    end
    return_value
  end

	def save
    return save_imported_records
  end

end
