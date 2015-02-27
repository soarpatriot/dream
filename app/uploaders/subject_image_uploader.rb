class SubjectImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
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

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:

  version :show, :if => :not_gif_or_bigger_than_800? do
    process :resize_to_fit => [800, 999999]
  end

  version :thumb do
    process :resize_to_fit => [160, 999999]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  private

  def not_gif_or_bigger_than_800? picture
    image = MiniMagick::Image.open(picture.path)
    image[:width] > 800 and !picture.path.end_with?("gif")
  end

end
