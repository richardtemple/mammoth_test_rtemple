require_relative "helpers/partner_helper"
require 'partner'
require 'affiliate'
require 'reseller'
require 'direct'

##
# This is the main class for the coding challenge.  It takes data in the form of a collection
# of Order objects.

class ReportBuilder

	def initialize(order_collection)
		@partners = []
		order_collection.uniq {|order| order.partner_name}.each do |real_order|
			my_klass = Object.const_get(real_order.program_type.to_s.capitalize)

      @partners << my_klass.new(partner_name: real_order.partner_name,
                                amount_charges_per_item: PartnerHelper.determine_amount_charges(
                                                          program_type: real_order.program_type,
                                                          partner_name: real_order.partner_name),
                                program_type: real_order.program_type
      )
		end

		order_collection.each do |order|
			@partners.select {|partner| partner.partner_name == order.partner_name}.first.orders << order
		end

	end

  ##
  # Returns a ruby hash with data on how much we should bill our partners this month
  #
	def create_amount_to_bill_report
		
		report = {}

		@partners.each do |partner|
			next if(partner.program_type == :direct) 
			report[partner.partner_name] = {}

			report[partner.partner_name][:amount_to_bill] = partner.amount_due 
		end

		report
	end

  ##
  # Returns a ruby hash containing the profits each partner made this month
  #
	def create_partner_profit_report
		report = {}

			@partners.each do |partner|
				next if(partner.program_type == :direct) 
				report[partner.partner_name] = {}

				report[partner.partner_name][:profit] = partner.profit 
			end

		report
	end

  ##
  # Returns a ruby hash containing the revenue for each program type with a total revenue
  #
	def create_revenue_report
		report = {}
		affiliates = 0
		resellers = 0
		direct = 0

		@partners.each do |partner|
			if partner.program_type == :affiliate
				affiliates += partner.amount_due
			elsif partner.program_type == :reseller
				resellers += partner.amount_due
			else
				direct += partner.profit
			end
		end
		
		report[:affiliates] = affiliates
		report[:resellers]  = resellers
		report[:direct]     = direct
		report[:total]      = affiliates + resellers + direct

		report
	end
end
