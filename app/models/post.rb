class Post < ApplicationRecord
    belongs_to :user
    default_scope -> { order(created_at: :desc) }

    #validate  :image_size

    private

    def picture_size
        if image.size > 5.megabytes
            errors.add(:image, "should be less than 5MB")
        end
    end

end
