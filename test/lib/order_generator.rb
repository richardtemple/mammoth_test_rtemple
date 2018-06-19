require_relative '../../lib/helpers/partner_helper'

##
# This is a fixture generator for the coding challenge
#
class OrderGenerator

	PROGRAM_TYPES = {direct: ["Direct"], 
									 affiliate: ["ACompany", "AnotherCompany", "EvenMoreCompany"],
									 reseller: ["ResellThis", "SellMoreThings"]}


	def self.create_orders
		orders = []

		100.times do
			quantity = rand(100) + 1
			program_type = PROGRAM_TYPES.keys.sample
			partner_name = PROGRAM_TYPES[program_type].sample 
			amount_paid = determine_amount_paid(program_type: program_type, partner_name: partner_name, quantity: quantity)
			
			orders << Order.new(quantity: quantity, 
													program_type: program_type,
													partner_name: partner_name,
													amount_paid: amount_paid)
		end
		orders
	end

	def self.determine_amount_paid(program_type: nil, partner_name: nil, quantity: nil)
		price_per_widget = PartnerHelper.determine_amount_charges(program_type: program_type,
																															partner_name: partner_name)
		price_per_widget * quantity
	end
end