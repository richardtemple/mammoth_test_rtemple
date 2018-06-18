require 'test_helper'

describe ReportBuilder do
  before do
    @report_builder = ReportBuilder.new
  end

  describe "buld a report" do
    
    it "must respond positively" do
      true.must_equal true
    end

    it "should output data" do
    	data = OrderGenerator.create_orders
    	report = @report_builder.create_report data: data
    	refute_nil report
    end
  end
end	
  