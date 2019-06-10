class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def image_size
    if image.size > 5.megabytes
        errors.add(:image, "should be less than 5MB")
    end
  end
end
