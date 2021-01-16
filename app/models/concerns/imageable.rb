module Imageable
  # extend(ActiveSupport::Concern)
  # inluded do
  #   has_one(:image, as: :imageable)
  # end

  def attach(file)
    file_name = User.create_token
    extension = file.content_type.match(/.+\/(.+)/)[1]
    content = File.read(file.tempfile)
    File.open("#{Rails.root}/app/javascript/images/#{file_name}.#{extension}", 'w') do |f|
      f.write(content)
    end
    image.create(file_name: "#{file_name}.#{extension}", file_type: extension, imageable_id: id, imageable_type: self.class.to_s)
  end

  private
    def validate_extention
      return false
    end

    def validate_file_size
      return false
    end
end