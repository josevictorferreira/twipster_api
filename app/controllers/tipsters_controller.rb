# frozen_string_literal: true

class TipstersController < ApplicationController
  before_action :set_tipster, only: %i[show update destroy]

  def index
    @tipsters = Tipster.all

    render json: @tipsters
  end

  def show
    render json: @tipster
  end

  def create
    @tipster = Tipster.new(tipster_params)

    if @tipster.save
      render json: @tipster, status: :created, location: @tipster
    else
      render json: @tipster.errors, status: :unprocessable_entity
    end
  end

  def update
    if @tipster.update(tipster_params)
      render json: @tipster
    else
      render json: @tipster.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @tipster.destroy
  end

  private

  def set_tipster
    @tipster = Tipster.find(params[:id])
  end

  def tipster_params
    params.require(:tipster).permit(:name, :user)
  end
end
