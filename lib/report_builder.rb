require_relative "helpers/partner_helper"
require 'partner'
require 'affiliate'
require 'reseller'
require 'direct'

class ReportBuilder

	def create_amount_to_bill_report(data:)
		
		report = {}
		partners = []
		
	  data.uniq {|order| order.partner_name}.each do |real_order|
	  	next if real_order.program_type == :direct
	  	my_klass = Object.const_get(real_order.program_type.to_s.capitalize)

	  	partners << my_klass.new(partner_name: real_order.partner_name, 
												amount_charges_per_item: PartnerHelper.determine_amount_charges(
																								program_type: real_order.program_type,
																							  partner_name: real_order.partner_name)
																								)
	  end

		data.each do |order| 
			next if order.program_type == :direct
			partners.select {|partner| partner.partner_name == order.partner_name}.first.orders << order
		end

		partners.each do |partner|
			report[partner.partner_name] = {}

			report[partner.partner_name][:amount_to_bill] = partner.amount_due
		end

		report
	end

	def create_partner_profit_report(data:)
		report = {}
		seller_groups = data.group_by do |order|
			order.partner_name
		end

		seller_groups.each do |data_set| 
			next if data_set[0] == "Direct"
			report[data_set[0]] = {}
			report[data_set[0]][:quantity] = 0
			data_set[1].each do |order|
				report[order.partner_name][:quantity] +=  order.quantity
				report[order.partner_name][:program_type] = order.program_type
			end
		end

		report
	end
end
