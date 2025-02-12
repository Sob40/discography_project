# frozen_string_literal: true

class ArtistsController < ApplicationController
  before_action :set_artist, only: %i[show edit update destroy]

  # GET /artists
  def index
    @artists = if params[:search].present?
                 Artist.by_name(params[:search]).ordered
               else
                 Artist.ordered
               end
  end

  # GET /artists/:id
  def show
    @lps = @artist.lps
  end

  # GET /artists/new
  def new
    @artist = Artist.new
  end

  # GET /artists/:id/edit
  def edit; end

  # POST /artists
  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      redirect_to @artist, notice: t('notices.artist_created')
    else
      render :new
    end
  end

  # PATCH/PUT /artists/:id
  def update
    if @artist.update(artist_params)
      redirect_to @artist, notice: t('notices.artist_updated')
    else
      render :edit
    end
  end

  # DELETE /artists/:id
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
