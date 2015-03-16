class UserAvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  CarrierWave.root = "#{G2.config.root_dir}"
  
  # Choose what kind of storage to use for this uploader:
  storage :qiniu
  # storage :fog
  def store_dir
    "#{G2.config.root_dir}/public/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
