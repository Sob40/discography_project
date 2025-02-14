# frozen_string_literal: true

class AuthorsController < ApplicationController
  def index
    @authors = Author.order(:name)
  end

  def show
    @author = Author.find(params[:id])
  end

  def new
    @author = Author.new
  end

  def edit
    @author = Author.find(params[:id])
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      redirect_to authors_path, notice: t('notices.author_created', default: 'Author was successfully created.')
    else
      render :new
    end
  end

  def update
    author = Author.find(params[:id])
    if author.update(author_params)
      redirect_to authors_path, notice: t('notices.author_updated', default: 'Author was successfully updated.')
    else
      render :edit
    end
  end

  def destroy
    author = Author.find(params[:id])
    author.destroy
    redirect_to authors_url, notice: t('notices.author_destroyed', default: 'Author was successfully destroyed.')
  end

  private

  def author_params
    params.require(:author).permit(:name)
  end
end
