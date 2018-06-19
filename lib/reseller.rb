##
# Contains specific rules for Reseller Partners
#
class Reseller < Partner

	def amount_due
		total_orders * 50
	end

	def profit
		(total_orders * @amount_charges_per_item) - amount_due
	end
end