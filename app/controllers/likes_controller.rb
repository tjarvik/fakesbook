class LikesController < ApplicationController
    def create
        like_params
        @like = Like.new(likeable_type: 'Post', likeable_id: params[:likes][:post_id])
        @like.user = current_user
        current_post = Post.find(params[:likes][:post_id])
        @like.save unless Like.where("user_id = ? AND likeable_id = ? AND likeable_type = ?",
            current_user.id, current_post.id, 'Post').any?
        redirect_to posts_path
    end

private

    def like_params
        params.fetch(:likes).permit(:post_id)
    end
end
