require 'test_helper'

describe ReportBuilder do
  before do
    @report_builder = ReportBuilder.new
  end

  describe "buld how much to bill report" do

    it "should output data" do
    	data = OrderGenerator.create_orders
    	report = @report_builder.create_amount_to_bill_report data: data
      puts "report: #{report}"
    	assert report.count > 0
    end

    it "should total affiliates correctly" do
      data = [Order.new(amount_paid: 2640, program_type: :affiliate, quantity: 33, partner_name: "EvenMoreCompany"),
              Order.new(amount_paid: 6000, program_type: :affiliate, quantity: 80, partner_name: "EvenMoreCompany")]
      report = @report_builder.create_amount_to_bill_report data: data

      # quantity (113) * rate (60) = 6780
      assert report.first[1][:amount_to_bill] == 6780, "Expected 6780, was #{report.first[1]}"
    end

    it "should total reseller correctly" do
      data = [Order.new(amount_paid: 1500, program_type: :reseller, quantity: 20, partner_name: "ResellThis"),
              Order.new(amount_paid: 6000, program_type: :reseller, quantity: 80, partner_name: "ResellThis")]
      report = @report_builder.create_amount_to_bill_report data: data

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

      report = @report_builder.create_amount_to_bill_report data: data
      assert report["ResellThis"][:amount_to_bill] == 5000
      assert report["EvenMoreCompany"][:amount_to_bill] == 6780
      assert report["Direct"] == nil, "Direct amount off: #{report["Direct"]}"
    end
  end

  describe "build partner profit report" do
    it "should output data" do
      data = OrderGenerator.create_orders
      report = @report_builder.create_partner_profit_report data: data
      puts "report: #{report}"
      assert report.count > 0
    end
  end

  describe "build revenue report" do
  end
end	
  