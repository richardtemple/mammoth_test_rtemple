require 'test_helper'

describe Order do

  before do
    @order = Order.new(quantity: 10, program_type: :direct)
  end

  describe "should have attributes" do
    it "should have quantity" do
      @order.quantity.must_equal 10
    end

    it "should have program_type" do
      @order.program_type.must_equal :direct
    end

		it "should have amount_paid" do
      @order.amount_paid = 1000
      @order.amount_paid.must_equal 1000
    end
    
    it "should have seller" do
      @order.seller = "ACompany"
      @order.seller.must_equal "ACompany"
    end
  end
end