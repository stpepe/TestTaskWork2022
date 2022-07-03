class PostsController < ApplicationController
    before_action :find_post!, only: [:show, :destroy, :edit, :update]
    before_action :permission_deny, only: [:edit, :destroy]
    before_action :require_authentication, only: [:new, :edit]

    def index
        @pagy, @posts = pagy Post.order(created_at: :desc)
    end

    def own
        #user = current_user
        @pagy, @posts = pagy Post.where user_id: params[:user_id] 
    end

    def new
       @post = Post.new 
    end

    def create
            @post = current_user.posts.build post_params
            if @post.save
                redirect_to posts_path
                flash[:success]="Запись создана"
            else
                render :new
            end
    end

    def edit
    end

    def update
            if @post.update post_params
                redirect_to post_path
                flash[:success]="Запись изменена"
            else
                render :edit
            end
    end

    def destroy
        @post.destroy
        redirect_to posts_path, status: 303
        flash[:success]="Запись удалена"
    end

    def show
        @comment = @post.comments.build
        @pagy, @comments = pagy @post.comments.order(created_at: :desc)
    end

    private

    def post_params
        params.require(:post).permit(:title, :body)
    end

    def find_post!
        @post = Post.find params[:id]
    end    

    def permission_deny
        if owner?(@post) == false then 
            redirect_back(fallback_location: root_path)
            flash[:warning]="Вы не автор поста!"
        end
    end
end