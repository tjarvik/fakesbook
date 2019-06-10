class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :likes, as: :likeable, dependent: :destroy

    default_scope -> { order(updated_at: :desc) }
    mount_uploader :image, ImageUploader
    validate  :image_size

    def likes_count
        Like.where("likeable_id = ? AND likeable_type = ?", self.id, 'Post').count
    end

    private

    def image_size
        if image.size > 5.megabytes
            errors.add(:image, "should be less than 5MB")
        end
    end

end
