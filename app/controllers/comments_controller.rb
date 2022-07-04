class CommentsController < ApplicationController
    before_action :find_post!
    before_action :find_comment!, only: [:update, :edit, :destroy]
    before_action :permission_deny, only: [:edit, :destroy]

    def create
        @comment = @post.comments.build comment_create_params

        if @comment.save
            redirect_to post_path(@post)
            flash[:success] = "Ответ отправлен"
        else
            @pagy, @comments = pagy @post.comments.order(created_at: :desc)
            render "posts/show"
        end 
    end 

    def destroy
        @comment.destroy 
        redirect_to post_path(@post), status: 303
        flash[:success]="Комментарий удален"
    end

    def edit
        @comment = @post.comments.find params[:id]
    end

    def update
        if @comment.update comment_update_params
            flash[:success] = "Комментарий изменен"
            redirect_to post_path(@post)
        else
            render :edit, status: :unprocessable_entity
        end 
    end 

    private 

    def comment_create_params
        params.require(:comment).permit(:body).merge(user_id: current_user.id)
    end

    def comment_update_params
        params.require(:comment).permit(:body)
    end

    def find_post!
        @post = Post.find params[:post_id]
    end  

    def find_comment!
        @comment = Comment.find params[:id]
    end
    
    def permission_deny
        if owner?(@comment) == false then 
            redirect_back(fallback_location: root_path)
            flash[:warning]="Вы не автор поста!"
        end
    end
end
