class CustomerDeliveryPreference < ApplicationRecord
  validates_presence_of :milkman_product_id, :shift, :quantity, :starting_date
  validate :ending_date_after_starting_date
  validate :starting_date_after_present_date

  belongs_to :milkman_customer
  belongs_to :milkman_product

  private

    def ending_date_after_starting_date
      if ending_date < starting_date
        errors.add :base, "Ending date must be after the start date"
      end
    end

    def starting_date_after_present_date
      return if starting_date.blank?

      if starting_date < Date.today
        errors.add :base, "Starting date must be after the present date"
      end
    end

end
