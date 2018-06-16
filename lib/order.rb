class Order

	attr_accessor :quantity, :program_type, :amount_paid, :seller

	def initialize(quantity: nil, program_type: nil)
		@quantity = quantity
		@program_type = program_type
	end
end