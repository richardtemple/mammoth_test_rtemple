class Order

	attr_reader :quantity, :program_type, :amount_paid, :seller

	def initialize(quantity: nil, program_type: nil, seller: nil, amount_paid: nil)
		@quantity = quantity
		@program_type = program_type
		@seller = seller
		@amount_paid = amount_paid
	end
end