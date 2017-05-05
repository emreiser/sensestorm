class InspirationsController < ApplicationController

  def index
    @inspirations = Inspiration.all.order(created_at: :desc)
  end

  def new
    @inspiration = Inspiration.new
  end

  def create
    @inspiration = Inspiration.create!(inspiration_params)
    data = inspiration_params[:image]
    filename = "image_#{@inspiration.id}_#{DateTime.now.to_date}.jpg"

    File.open("#{Rails.root}/public/#{filename}", 'wb') do |f|
      f.write Base64.decode64(data['data:image/jpg;base64,'.length .. -1])
    end

    @inspiration.image = URI.join(root_url, filename).to_s
    @inspiration.save
    redirect_to action: "index"
  end

  private

  def inspiration_params
    params.require(:inspiration).permit(:sense, :application, :image)
  end

end
