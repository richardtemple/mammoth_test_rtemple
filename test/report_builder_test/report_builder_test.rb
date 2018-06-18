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
      data = [Order.new(amount_paid: 2640, program_type: :affiliates, quantity: 33, seller: "EvenMoreCompany"),
              Order.new(amount_paid: 6000, program_type: :affiliates, quantity: 80, seller: "EvenMoreCompany")]
      report = @report_builder.create_amount_to_bill_report data: data

      # quantity (113) * rate (60) = 6780
      assert report.first[1][:amount_to_bill] == 6780
    end

    it "should total resellers correctly" do
      data = [Order.new(amount_paid: 1500, program_type: :resellers, quantity: 20, seller: "ResellThis"),
              Order.new(amount_paid: 6000, program_type: :resellers, quantity: 80, seller: "ResellThis")]
      report = @report_builder.create_amount_to_bill_report data: data

      # quantity (100) * rate (50) = 5000
      assert report.first[1][:amount_to_bill] == 5000
    end

    it "should not confuse program_types" do
      data = [Order.new(amount_paid: 1500, program_type: :resellers, quantity: 20, seller: "ResellThis"),
              Order.new(amount_paid: 6000, program_type: :resellers, quantity: 80, seller: "ResellThis"),
              Order.new(amount_paid: 2640, program_type: :affiliates, quantity: 33, seller: "EvenMoreCompany"),
              Order.new(amount_paid: 6000, program_type: :affiliates, quantity: 80, seller: "EvenMoreCompany"),
              Order.new(amount_paid: 3300, program_type: :direct, quantity: 33, seller: "Direct"),
              Order.new(amount_paid: 8000, program_type: :direct, quantity: 80, seller: "Direct")]
              
      report = @report_builder.create_amount_to_bill_report data: data
      assert report["ResellThis"][:amount_to_bill] == 5000
      assert report["EvenMoreCompany"][:amount_to_bill] == 6780
      assert report["Direct"] == nil
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
  