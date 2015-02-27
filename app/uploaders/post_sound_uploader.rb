require 'carrierwave/orm/activerecord'
class PostSoundUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave

  CarrierWave.root = "#{G2.config.root_dir}"
  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog
  asset_host Settings.asset_host
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{G2.config.root_dir}/public/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end



end
