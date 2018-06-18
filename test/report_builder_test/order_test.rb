require 'test_helper'

describe Order do

  before do
    @order = Order.new(quantity: 10, program_type: :direct, partner_name: "Direct", amount_paid: 1000)
  end

  describe "should have attributes" do
    it "should have quantity" do
      @order.quantity.must_equal 10
    end

    it "should have program_type" do
      @order.program_type.must_equal :direct
    end

		it "should have amount_paid" do
      assert(@order.amount_paid > 0, "Problem #{@order.quantity} times #{@order.amount_paid}") 
    end
    
    it "should have partner_name" do
      @order.partner_name.must_equal "Direct"
    end   
  end
end