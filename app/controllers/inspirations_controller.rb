class InspirationsController < ApplicationController

  def index
    @inspirations = Inspiration.all.order(created_at: :desc)
  end

  def new
    @inspiration = Inspiration.new
  end

  def create
    @inspiration = Inspiration.create!(inspiration_params)
    image_data = inspiration_params[:image]

    @inspiration.upload_image_to_s3(image_data)
    redirect_to action: "index"
  end

  private

  def inspiration_params
    params.require(:inspiration).permit(:sense, :application, :image)
  end

end
