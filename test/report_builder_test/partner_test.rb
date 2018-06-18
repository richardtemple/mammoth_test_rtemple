require 'test_helper'

describe Partner do
	
	before do
    @partner = Partner.new(partner_name: "ACompany",
    											 amount_charges_per_item: 75)
  end

	describe "can manage orders" do
		it "can add order" do
			# require 'pry';binding.pry
			before_count = @partner.total_orders
			# require 'pry';binding.pry
			@partner.add_order(Order.new(amount_paid: 1500, program_type: :resellers, quantity: 20, seller: "ResellThis"))
			# require 'pry';binding.pry
			after_count = @partner.total_orders
			# require 'pry';binding.pry
			assert(after_count == 20, "Started with #{before_count} then ended up with #{after_count}")
		end
	end

end