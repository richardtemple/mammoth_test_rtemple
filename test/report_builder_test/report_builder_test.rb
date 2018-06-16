require 'test_helper'

describe ReportBuilder do
  before do
    @report_builder = ReportBuilder.new
  end

  describe "buld a report" do
    it "must respond positively" do
      true.must_equal true
    end
  end
end