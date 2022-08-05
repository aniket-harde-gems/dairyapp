class CustomerDeliveryRecurring < ApplicationRecord
  belongs_to :customer_delivery_preference
  has_one :milkman_customer, through: :customer_delivery_preference
  enum recurring_type: { daily: 0, weekly: 1 }

  validates :customer_delivery_preference_id, :recurring_type, presence: true
  # validates :day_of_week, :presence => true, if: Proc.new { |a| a.weekly_recurring? }
  # validates :day_of_week, inclusion: { in: (0..6).to_a,  message: "%{value} is not a day of week" }, allow_blank: true
  # validates :recurring_type, inclusion: { in: %w{daily weekly},  message: "%{value} is not a recurring type" }
  # validates :seperation_count, inclusion: { in: (0..2).to_a,  message: "%{value} is not a seperation_count" }
  # validate :validate_seperation_count
  # validate :validates_uniqueness_of_record

  # private

  #   def validate_seperation_count
  #     if (self.daily_recurring? && self.seperation_count > 2) || (self.weekly_recurring? && self.seperation_count != 0)
  #       errors.add(:base, 'Invalid recurring type')
  #     end
  #   end

  #   def validates_uniqueness_of_record
  #     is_exist = false
  #     customer_delivery_preferences = if !self.customer_delivery_preference_id.present?
  #     self.customer_delivery_preference.milkman_buyer_customer.customer_delivery_preferences
  #     else
  #       self.customer_delivery_preference.milkman_buyer_customer.customer_delivery_preferences.where('customer_delivery_preferences.id != ?', self.customer_delivery_preference_id)
  #     end

  #     if self.daily_recurring? and self.seperation_count == 0 #Daily Recurring
  
  #       is_exist = customer_delivery_preferences.where('shift = ? and milkman_product_id = ?',
  #       self.customer_delivery_preference.shift_type_cast, self.customer_delivery_preference.milkman_product_id
  #       ).any?

  #     elsif self.daily_recurring? and self.seperation_count == 1 #Alternate days Recurring
  
  #       is_exist = cus_delivery_preference_records(customer_delivery_preferences, [0, 1], [0]).any?
  #       if (!is_exist)
  #         records = cus_delivery_preference_records(customer_delivery_preferences, [0], [1])
  #         is_exist = records.pluck(:start_date).map{|sd| (sd - self.customer_delivery_preference.start_date).to_i%2 == 0}.include? true
  #       end
  
  #     elsif self.daily_recurring? and self.seperation_count == 2 #Every Third days Recurring
  #       is_exist = cus_delivery_preference_records(customer_delivery_preferences, [0, 1], [0, 1]).any?
  
  #       if (!is_exist)
  #         records = cus_delivery_preference_records(customer_delivery_preferences, [0], [2])
  #         is_exist = records.pluck(:start_date).map{|sd| (sd - self.customer_delivery_preference.start_date).to_i%3 == 0}.include? true
  #       end
  
  #     elsif self.weekly_recurring?
  #       is_exist = customer_delivery_preferences.where('shift = ? and milkman_product_id = ?',
  #       self.customer_delivery_preference.shift_type_cast, self.customer_delivery_preference.milkman_product_id
  #       ).any?
  
  #       if (!is_exist)
  #         records = cus_delivery_preference_records(
  #         customer_delivery_preferences, [1], [0]
  #         ).select('customer_delivery_recurrings.day_of_week').pluck(:day_of_week)
  #         is_exist = records.include? self.day_of_week
  #       end
  #     end
  
  #     if (is_exist)
  #       self.errors.add(:base, "You can not add #{self.customer_delivery_preference.milkman_product.product_name} for shift #{self.customer_delivery_preference.shift.titlecase} again, it is already exist")
  #     end
  #   end

  #   def cus_delivery_preference_records(customer_delivery_preferences, recurring_type_in, seperation_count_in)
  #     records = customer_delivery_preferences
  #     .joins(:customer_delivery_recurrings)
  #     .where('customer_delivery_preferences.shift = ?
  #     and customer_delivery_preferences.milkman_product_id = ?
  #     and customer_delivery_recurrings.recurring_type IN (?)
  #     and customer_delivery_recurrings.seperation_count IN (?)',
  #     self.customer_delivery_preference.shift_type_cast,
  #     self.customer_delivery_preference.milkman_product_id,
  #     recurring_type_in,
  #     seperation_count_in
  #     )
  #     records
  #   end

end
