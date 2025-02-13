# frozen_string_literal: true

class ArtistsController < ApplicationController
  before_action :set_artist, only: %i[show edit update destroy]

  def index
    @artists = if params[:search].present?
                 Artist.by_name(params[:search]).ordered
               else
                 Artist.ordered
               end
  end

  def show
    @lps = @artist.lps
  end

  def new
    @artist = Artist.new
  end

  def edit; end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      redirect_to @artist, notice: t('notices.artist_created')
    else
      render :new
    end
  end

  def update
    if @artist.update(artist_params)
      redirect_to @artist, notice: t('notices.artist_updated')
    else
      render :edit
    end
  end

  def destroy
    @artist.destroy
    redirect_to artists_url, notice: t('notices.artist_destroyed')
  end

  private

  def set_artist
    @artist = Artist.find(params[:id])
  end

  def artist_params
    params.expect(artist: %i[name description])
  end
end
