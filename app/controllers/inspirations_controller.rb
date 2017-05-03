class InspirationsController < ApplicationController

  def index
    @inspirations = Inspiration.all
    @inspiration = Inspiration.new
  end

  def create
    @inspiration = Inspiration.create!(inspiration_params)
    data = inspiration_params[:image]
    filename = "#{Rails.root}/public/image_#{@inspiration.id}_#{DateTime.now.to_date}.png"
    File.open(filename, 'wb') do |f|
      f.write Base64.decode64(data['data:image/png;base64,'.length .. -1])
    end

    @inspiration.image = filename
    @inspiration.save
    redirect_to action: "index"
  end

  private

  def inspiration_params
    params.require(:inspiration).permit(:sense, :application, :image)
  end

end
