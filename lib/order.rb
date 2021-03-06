##
# Information received as an order from either affiliates, resellers, or direct sales.
# It's initialized with quantity, program_type, partner_name, and amount_paid.
#
class Order

	attr_reader :quantity, :program_type, :amount_paid, :partner_name

	def initialize(quantity: nil, program_type: nil, partner_name: nil, amount_paid: nil)
		@quantity     = quantity
		@program_type = program_type
		@partner_name = partner_name
		@amount_paid  = amount_paid
	end
end