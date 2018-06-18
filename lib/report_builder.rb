class ReportBuilder

	def create_report(data:)
		report = {}
		
		x = 1
		
		groups = data.group_by do |order|
			order.seller
		end

		groups.each do |data_set| 
			report[data_set[0]] = 0
			data_set[1].each do |order|
				report[order.seller] +=  order.quantity
				x += 1
			end
		end
		report
	end
end
