# frozen_string_literal: true

class ReportsController < ApplicationController
  def index
    @lps = Lp.with_report_data

    @lps.each do |lp|
      lp.authors_list = lp.authors_list.gsub(',', ', ') if lp.authors_list.present?
    end
  end
end
