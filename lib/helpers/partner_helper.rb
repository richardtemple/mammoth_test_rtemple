##
# This module is to help break out mundane methods needed to manage partner data.
#
module PartnerHelper
	def self.determine_amount_charges(program_type: nil, partner_name: nil)
		
		if (program_type == :affiliate)
			if partner_name == "ACompany"
				price_per_widget = 75
			elsif partner_name == "AnotherCompany"
				price_per_widget = 65
			else
				price_per_widget = 80
			end
		elsif (program_type == :reseller)
			if partner_name == "ResellThis"
				price_per_widget = 75
			else
				price_per_widget = 85
			end
		else
			price_per_widget = 100 # direct
		end
	end
end
