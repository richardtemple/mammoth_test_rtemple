class Direct < Partner

	def amount_due
		0
	end

	def profit
		(total_orders * @amount_charges_per_item) - amount_due
	end
end