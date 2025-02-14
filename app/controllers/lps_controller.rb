# frozen_string_literal: true

class LpsController < ApplicationController
  before_action :set_lp, only: %i[show edit update destroy]

  def index
    @lps = if params[:artist].present?
             Lp.by_artist_name(params[:artist]).ordered
           else
             Lp.ordered
           end
  end

  def show; end

  def new
    @lp = Lp.new
    @lp.songs.build
  end

  def edit; end

  def create
    @lp = Lp.new(lp_params)
    if @lp.save
      redirect_to @lp, notice: t('notices.lp_created', default: 'LP was successfully created.')
    else
      render :new
    end
  end

  def update
    if @lp.update(lp_params)
      redirect_to @lp, notice: t('notices.lp_updated', default: 'LP was successfully updated.')
    else
      render :edit
    end
  end

  def destroy
    @lp.destroy
    redirect_to lps_url, notice: t('notices.lp_destroyed', default: 'LP was successfully destroyed.')
  end

  private

  def set_lp
    @lp = Lp.find(params[:id])
  end

  def lp_params
    permitted = params.require(:lp).permit(
      :name, :description, :artist_id,
      songs_attributes: [:id, :name, :_destroy, { author_ids: [] }]
    )

    permitted['songs_attributes']&.each_value do |song_attrs|
      song_attrs['author_ids'] = song_attrs['author_ids'].compact_blank if song_attrs['author_ids'].is_a?(Array)
    end

    permitted
  end
end
