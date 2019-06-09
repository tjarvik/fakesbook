class Post < ApplicationRecord
    belongs_to :user
    default_scope -> { order(created_at: :desc) }
    mount_uploader :image, ImageUploader
    validate  :image_size

    private

    def image_size
        if image.size > 5.megabytes
            errors.add(:image, "should be less than 5MB")
        end
    end

end
