class OrderGenerator

	# DIRECT_TYPE_INFO = [{name: "Direct", amount_each: 100}]
	# AFFILIATE_TYPE_INFO = [{name: "ACompany", amount_each: , "AnotherCompany", "EvenMoreCompany"}
	PROGRAM_TYPES = {direct: ["Direct"], 
									 affiliates: ["ACompany", "AnotherCompany", "EvenMoreCompany"],
									 resellers: ["ResellThis", "SellMoreThings"]}


	def self.create_orders
		orders = []

		100.times do
			quantity = rand(1800) + 1
			program_type = PROGRAM_TYPES.keys.sample
			seller = PROGRAM_TYPES[program_type].sample 
			amount_paid = determine_amount_paid(program_type: program_type, seller: seller, quantity: quantity)
			
			orders << Order.new(quantity: quantity, 
													program_type: program_type,
													seller: seller,
													amount_paid: amount_paid)
			puts "amount_paid = #{amount_paid}, program_type = #{program_type}, seller = #{seller}, quantity = #{quantity}"
		end
		orders
	end

	def self.determine_amount_paid(program_type: nil, seller: nil, quantity: nil)
		
		price_per_widget = 0
		
		if (program_type = :affiliates)
			if quantity > 1000
				price_per_widget = 40
			elsif quantity > 500
				price_per_widget = 50
			else
				price_per_widget = 60
			end
		elsif (program_type == :resellers)
			price_per_widget = 50
		else
			price_per_widget = 100 # direct
		end
		price_per_widget * quantity
	end
end