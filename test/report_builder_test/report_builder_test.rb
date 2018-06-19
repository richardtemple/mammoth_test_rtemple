require 'test_helper'

describe ReportBuilder do
  before do
    @report_builder = ReportBuilder.new(OrderGenerator.create_orders)
  end

  describe "buld how much to bill report" do

    it "should output data" do
    	report = @report_builder.create_amount_to_bill_report
      puts "Receivables report: #{report}"
    	assert report.count > 0
    end

    it "should total affiliates correctly" do
      data = [Order.new(amount_paid: 2640, program_type: :affiliate, quantity: 33, partner_name: "EvenMoreCompany"),
              Order.new(amount_paid: 6000, program_type: :affiliate, quantity: 80, partner_name: "EvenMoreCompany")]
      report = ReportBuilder.new(data).create_amount_to_bill_report

      # quantity (113) * rate (60) = 6780
      assert report.first[1][:amount_to_bill] == 6780, "Expected 6780, was #{report.first[1]}"
    end

    it "should total reseller correctly" do
      data = [Order.new(amount_paid: 1500, program_type: :reseller, quantity: 20, partner_name: "ResellThis"),
              Order.new(amount_paid: 6000, program_type: :reseller, quantity: 80, partner_name: "ResellThis")]
      report = ReportBuilder.new(data).create_amount_to_bill_report

      # quantity (100) * rate (50) = 5000
      assert report.first[1][:amount_to_bill] == 5000
    end

    it "should not confuse program_types" do
      data = [Order.new(amount_paid: 1500, program_type: :reseller, quantity: 20, partner_name: "ResellThis"),
              Order.new(amount_paid: 6000, program_type: :reseller, quantity: 80, partner_name: "ResellThis"),
              Order.new(amount_paid: 2640, program_type: :affiliate, quantity: 33, partner_name: "EvenMoreCompany"),
              Order.new(amount_paid: 6000, program_type: :affiliate, quantity: 80, partner_name: "EvenMoreCompany"),
              Order.new(amount_paid: 3300, program_type: :direct, quantity: 33, partner_name: "Direct"),
              Order.new(amount_paid: 8000, program_type: :direct, quantity: 80, partner_name: "Direct")]

      report = ReportBuilder.new(data).create_amount_to_bill_report

      assert report["ResellThis"][:amount_to_bill] == 5000, "Resell amount off: #{report["ResellThis"]}"
      assert report["EvenMoreCompany"][:amount_to_bill] == 6780, "Direct amount off: #{report["EvenMoreCompany"]}"
      assert report["Direct"] == nil, "Direct amount off: #{report["Direct"]}"
    end
  end

  describe "build partner profit report" do
    it "should output data" do
      report = @report_builder.create_partner_profit_report
      puts "Profit report: #{report}"
      assert report.count > 0
    end

    it "neeeds more tests" do
    end
  end

  describe "build revenue report" do
    it "should output data" do
      report = @report_builder.create_revenue_report
      puts "Revenue report: #{report}"
      assert report.count > 0
    end
    
    it "neeeds more tests" do
    end
  end
end	
  