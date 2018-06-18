require 'test_helper'

describe OrderGenerator do

	before do
    @orders = OrderGenerator.create_orders
  end

  describe "generate orders" do
    it "should return 100 Orders" do
      @orders.count.must_equal(100)
    end

    describe "valid attributes" do
    	it "should have valid values for each attribute" do
    		assert_includes(1..1800, 
    										@orders[0].quantity, 
    										msg = "should be a number between 1 and 100")
    		assert_includes(OrderGenerator::PROGRAM_TYPES.keys, 
    										@orders[0].program_type, 
    										msg = "should be a valid program type")
    		assert_includes(OrderGenerator::PROGRAM_TYPES[@orders[0].program_type], 
    										@orders[0].partner_name, 
    										msg = "should be a valid seller")
    		assert(@orders[0].amount_paid > @orders[0].quantity * 39, "amount paid is off")
    	end
    end
  end
end