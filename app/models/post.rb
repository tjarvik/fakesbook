class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :likes, as: :likeable, dependent: :destroy

    default_scope -> { order(updated_at: :desc) }
    mount_uploader :image, ImageUploader
    validate  :image_size

    private

    def image_size
        if image.size > 5.megabytes
            errors.add(:image, "should be less than 5MB")
        end
    end

end
