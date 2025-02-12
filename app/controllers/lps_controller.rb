# frozen_string_literal: true

class LpsController < ApplicationController
  def index
    @lps = if params[:artist].present?
             Lp.by_artist_name(params[:artist]).ordered
           else
             Lp.ordered
           end
  end

  def show; end

  def new; end

  def edit; end
end
