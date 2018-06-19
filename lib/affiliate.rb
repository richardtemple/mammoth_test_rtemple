class Affiliate < Partner

	def amount_due
		if total_orders > 1000
			amount_due = total_orders * 40
		elsif total_orders > 500
			amount_due = total_orders * 50
		else
			amount_due = total_orders * 60
		end
		amount_due
	end

	def profit
		(total_orders * @amount_charges_per_item) - amount_due
	end
end