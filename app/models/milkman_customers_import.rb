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
    header = ["Customer Name", "Customer Address", "Customer Mobile Number", "Product Name", "Quantity", "Shift", "Starting Date", "Ending Date", "Recurring Type", "Day 1", "Day 2", "Day3", "Day4", "Day5", "Day6", "Day7"]
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
      all_customers = []
      all_mobile_numbers = []
      (2..spreadsheet.last_row).map do |i|
        all_customers << spreadsheet.row(i)[0]
        all_mobile_numbers << spreadsheet.row(i)[2]
      end

      (2..spreadsheet.last_row).map do |i|
        #Saving Milkman Customer
        header_for_customer = [ "customer_name" , "customer_address" , "customer_mobile_number" , "milkman_id" ]
        row_for_customer = []
        customer_name = ""
        customer_address = ""
        customer_mobile_number = ""
        product_name = ""
        quantity = ""
        shift = ""
        starting_date = ""
        ending_date = ""
        recurring_type = ""
        name_of_days = []

        spreadsheet.row(i).each_with_index do |data, idx|
          if idx == 0
            customer_name = data
          elsif idx == 1
            customer_address = data
          elsif idx == 2
            customer_mobile_number = data
          elsif idx == 3
            product_name = data
          elsif idx == 4
            quantity = data
          elsif idx == 5
            shift = data
          elsif idx == 6
            starting_date = data
          elsif idx == 7
            ending_date = data
          elsif idx == 8
            recurring_type = data
          elsif idx >= 9
            name_of_days << data
          end
        end

        if i != 2 && all_customers[i-3] == customer_name && all_mobile_numbers[i-3] == customer_mobile_number
          milkman_customer = MilkmanCustomer.find_by(customer_name: customer_name, customer_mobile_number: customer_mobile_number)
        else
          row_for_customer = [customer_name, customer_address, customer_mobile_number, Milkman.first.id]
          return_value, milkman_customer = save_milkmen_customer_record(header_for_customer, row_for_customer, i)
        end

        #Saving Milkman Customer Delivery Preference
        if milkman_customer.present? && !milkman_customer.errors.present?
          header_for_customer_delivery_preference = ["milkman_customer_id", "milkman_product_id", "quantity", "shift", "starting_date", "ending_date"]
          milkman_customer_id = milkman_customer.id
          milkman_product_id =  MilkmanProduct.find_by(product_name: product_name).id
          if shift === "Evening"
            shift = "e"
          elsif shift === "Morning"
            shift = "m"
          end
          row_for_customer_delivery_preference = [milkman_customer_id, milkman_product_id, quantity, shift, starting_date, ending_date]
          return_value, customer_delivery_preference = save_customer_delivery_preference_record(header_for_customer_delivery_preference,row_for_customer_delivery_preference, i)
        end

        #Saving Milkman Customer Delivery Recurring
        if customer_delivery_preference.present? && !customer_delivery_preference.errors.present?
          header_for_customer_delivery_recurring = [ "customer_delivery_preference_id", "recurring_type", "seperation_count"]
          customer_delivery_preference_id = customer_delivery_preference.id
          row_for_customer_delivery_recurring = [customer_delivery_preference_id]

          case recurring_type
          when "Daily"
            recurring_type_value = 0
            seperation_count = 0
            row_for_customer_delivery_recurring << recurring_type_value
            row_for_customer_delivery_recurring << seperation_count
          when "Alternate Days"
            recurring_type_value = 0
            seperation_count = 1
            row_for_customer_delivery_recurring << recurring_type_value
            row_for_customer_delivery_recurring << seperation_count
          when "Every Third Day"
            recurring_type_value = 0
            seperation_count = 2
            row_for_customer_delivery_recurring << recurring_type_value
            row_for_customer_delivery_recurring << seperation_count
          when "Week Day"
            recurring_type_value = 1
            seperation_count = 0
            row_for_customer_delivery_recurring << recurring_type_value
            row_for_customer_delivery_recurring << seperation_count
          end

          if recurring_type == "Week Day"
            unless name_of_days.compact!.present?
              errors.add :base, "Please select days of week"
              return false
            end
            header_for_customer_delivery_recurring << "day_of_week"
            if name_of_days.compact!.present?
              name_of_days.compact!.each do |day_name|
                row_for_customer_delivery_recurring[3] = DateTime.parse(day_name).wday
                return_value = save_custome_delivery_recurring_record(header_for_customer_delivery_recurring, row_for_customer_delivery_recurring, i)
              end
            end
          else 
            return_value = save_custome_delivery_recurring_record(header_for_customer_delivery_recurring, row_for_customer_delivery_recurring, i)
          end
        end
      end
      return_value
    end
  end

  def save_custome_delivery_recurring_record(header, row, i)
    attributes = Hash[[header, row].transpose]
    customer_delivery_recurring = CustomerDeliveryRecurring.new
    customer_delivery_recurring.attributes = attributes.to_hash
    if customer_delivery_recurring.valid?
      customer_delivery_recurring.save!
      return true
    else
      customer_delivery_recurring.errors.full_messages.each do |msg|
        errors.add :base, "Row #{i} can't save customer delivery recurring because: #{msg}"
        raise ActiveRecord::Rollback
      end
      return false
    end
  end

  def save_milkmen_customer_record(header, row, i)
    attributes = Hash[[header, row].transpose]
    milkman_customer = MilkmanCustomer.new
    milkman_customer.attributes = attributes.to_hash
    if milkman_customer.valid?
      milkman_customer.save!
      return true, milkman_customer
    else
      milkman_customer.errors.full_messages.each do |msg|
        errors.add :base, "Row #{i} can't save customer because: #{msg}"
        raise ActiveRecord::Rollback
      end
      return false, milkman_customer
    end
  end

  def save_customer_delivery_preference_record(header, row, i)
    attributes = Hash[[header, row].transpose]
    customer_delivery_preference = CustomerDeliveryPreference.new
    customer_delivery_preference.attributes = attributes.to_hash
    if customer_delivery_preference.valid?
      customer_delivery_preference.save!
      return true, customer_delivery_preference
    else
      customer_delivery_preference.errors.full_messages.each do |msg|
        errors.add :base, "Row #{i} can't save customer delivery preference because: #{msg}"
        raise ActiveRecord::Rollback 
      end
      return false, customer_delivery_preference
    end
  end

	def save
    return save_imported_records
  end

end
