class Partner
	attr_reader :partner_name, :amount_due, :profit
	attr_accessor :orders
	def initialize(partner_name:, orders: [], amount_charges_per_item:)
		@partner_name = partner_name
		@orders = orders
		@amount_charges_per_item = amount_charges_per_item
	end

	def add_order(new_order)
		@orders << new_order
	end

	def total_orders
		orders_count = 0
		@orders.each do |order|
			orders_count += order.quantity
		end
		orders_count
	end

	def amount_due
		raise "must implement this method in subclass"
	end

	def profit
		raise "must implement this method in subclass"
	end
end
