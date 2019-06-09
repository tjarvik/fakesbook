class CommentsController < ApplicationController
    
    def create
        @comment = Comment.new(comment_params)
        @comment.user = current_user
        @comment.post = Post.find(params[:comments][:post_id])
        if @comment.save!
            redirect_to posts_path, notice: "Okay, we'll see what people think of THAT."
        else
            redirect_to posts_path, notice: "Comment sucked and could not be posted."
        end
    end

    def update

    end

    def destroy

    end

private

    def comment_params
        params.fetch(:comments).permit(:body, :post_id)
    end
end
