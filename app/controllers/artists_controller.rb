# frozen_string_literal: true

class ArtistsController < ApplicationController
  # GET /artists
  def index
    @artists = if params[:search].present?
                 Artist.by_name(params[:search]).ordered
               else
                 Artist.ordered
               end
  end

  def show; end
  def new; end
  def edit; end
  def create; end
  def update; end
  def destroy; end
end
