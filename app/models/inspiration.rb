class Inspiration < ActiveRecord::Base

  def upload_image_to_s3(image_data)
    s3 = Aws::S3::Resource.new
    key = "image_#{self.id}_#{DateTime.now.to_date}.jpg"

    object = s3.bucket("chicago-sense-storm").object(key)
    object.put(
      acl: 'public-read',
      body: Base64.decode64(image_data['data:image/jpg;base64,'.length .. -1]))

    self.image = object.public_url.to_s
    self.save
  end

end
