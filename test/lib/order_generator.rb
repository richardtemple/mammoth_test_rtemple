class OrderGenerator
	PROGRAM_TYPES = [:direct, :affiliates, :resellers] # Method used
	def self.create_orders
		orders = []
		100.times do
			orders << Order.new(quantity: rand(100), 
													program_type: (PROGRAM_TYPES[rand(3) - 1]))
		end
		orders
	end
end