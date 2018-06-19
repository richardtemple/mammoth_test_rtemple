# Billing System coding challenge

Coded by Richard Temple

`ReportBuilder` is the main engine for these reports.  It takes a collection of 
Order objects in the constructor, then the report creation methods will use
that data to build the reports into a Ruby `Hash`.

There are three main methods used as the interface to `ReportBuilder`: 
  * `create_amount_to_bill_report`
  * `create_partner_profit_report`
  * `create_revenue_report`
