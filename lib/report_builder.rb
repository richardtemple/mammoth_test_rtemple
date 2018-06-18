class ReportBuilder

	def create_amount_to_bill_report(data:)
		
		report = {}
		
		seller_groups = data.group_by do |order|
			order.seller
		end

		seller_groups.each do |data_set| 
			next if data_set[0] == "Direct"
			report[data_set[0]] = {}
			report[data_set[0]][:quantity] = 0
			data_set[1].each do |order|
				report[order.seller][:quantity] +=  order.quantity
				report[order.seller][:program_type] = order.program_type
			end
		end

		report.each do |seller|
			if seller[1][:program_type] == :affiliates
				if seller[1][:quantity] > 1000
					seller[1][:amount_to_bill] = seller[1][:quantity] * 40
				elsif seller[1][:quantity] > 800
					seller[1][:amount_to_bill] = seller[1][:quantity] * 50
				else
					seller[1][:amount_to_bill] = seller[1][:quantity] * 60
				end
			else
				seller[1][:amount_to_bill] = seller[1][:quantity] * 50
			end
		end

		# should I remove superfluous data?
		report
	end

	def create_partner_profit_report(data:)
		report = {}
		seller_groups = data.group_by do |order|
			order.seller
		end

		seller_groups.each do |data_set| 
			next if data_set[0] == "Direct"
			report[data_set[0]] = {}
			report[data_set[0]][:quantity] = 0
			data_set[1].each do |order|
				report[order.seller][:quantity] +=  order.quantity
				report[order.seller][:program_type] = order.program_type
			end
		end

		# report.each do |seller|
		# 	if seller[1][:program_type] == :affiliates
		# 		if seller[1][:quantity] > 1000
		# 			seller[1][:amount_to_bill] = (seller[1][:quantity] *(seller[1][:quantity] * 40) 
		# 		elsif seller[1][:quantity] > 800
		# 			seller[1][:amount_to_bill] = seller[1][:quantity] * 50
		# 		else
		# 			seller[1][:amount_to_bill] = seller[1][:quantity] * 60
		# 		end
		# 	else
		# 		seller[1][:amount_to_bill] = seller[1][:quantity] * 50
		# 	end
		# end
		report
	end
end
