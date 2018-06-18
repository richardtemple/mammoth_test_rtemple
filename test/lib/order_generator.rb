class OrderGenerator

	PROGRAM_TYPES = {direct: ["Direct"], 
									 affiliates: ["ACompany", "AnotherCompany", "EvenMoreCompany"],
									 resellers: ["ResellThis", "SellMoreThings"]}


	def self.create_orders
		orders = []

		100.times do
			quantity = rand(100) + 1
			program_type = PROGRAM_TYPES.keys.sample
			seller = PROGRAM_TYPES[program_type].sample 
			amount_paid = determine_amount_paid(program_type: program_type, seller: seller, quantity: quantity)
			
			orders << Order.new(quantity: quantity, 
													program_type: program_type,
													seller: seller,
													amount_paid: amount_paid)
		end
		orders
	end

	def self.determine_amount_paid(program_type: nil, seller: nil, quantity: nil)
		
		price_per_widget = 0
		
		if (program_type == :affiliates)
			if seller == "ACompany"
				price_per_widget = 75
			elsif seller == "AnotherCompany"
				price_per_widget = 65
			else
				price_per_widget = 80
			end
		elsif (program_type == :resellers)
			if seller == "ResellThis"
				price_per_widget = 75
			else
				price_per_widget = 85
			end
		else
			price_per_widget = 100 # direct
		end
		price_per_widget * quantity
	end
end