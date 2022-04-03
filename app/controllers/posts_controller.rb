class PostsController < ApplicationController
    before_action :authorize
    def index    
        if params[:search]           
            @posts = Post.search(params[:search]).paginate(:page => params[:page], :per_page=>5)
        else  
        #    @posts = Post.all.paginate(:page => params[:page], :per_page=>5)
          # @posts = Post.all.paginate(page : params[:page], per_page : 5)
          @posts = Post.all.paginate(page: params[:page], per_page: 5)
        end 
    end

    def show
        p "SHOW"
        @post = Post.find(params[:id])
    end
    
    def new
        @post = Post.new
    end

    def confirm
        p "Confirm post"   
        @post = Post.new(post_params)
        p "POST data #{@post.inspect}"
        render "confirm_post" , status: :unprocessable_entity
    end

    def create
        p "CREATE_POST"
        post = Post.new(post_params)
        post.created_user_id = session[:user_id]
        post.updated_user_id = session[:user_id]
        post.user_id = current_user.id
        post.status = 1
        p "POST #{post.inspect}"
        puts post.title
        if post.save
            # If user saves in the db successfully:
            flash[:notice] = "Post created successfully!"
            redirect_to posts_path
        else
            # If user fails model validation - probably a bad password or duplicate email:
            flash.now.alert = "Oops, couldn't create post. Please try again."
            render :new, status: :unprocessable_entity
        end     
       
    end

    def edit
        @post = Post.find(params[:id])
        
    end

    def confirm_update
        @post = Post.new(post_params)
        p "UPDATE_Confirm_POST"
        render "confirm_post_update" , status: :unprocessable_entity
    end

    def update
        post = Post.find(params[:id])
        post.update(post_params)        
        redirect_to posts_path
    end

    def destroy
        p 'destroy'
        post = Post.find(params[:id])
        post.destroy
        redirect_to root_path
    end

    def import
        puts "import csv"
        Post.import_CSV(params[:file], session[:user_id])
        redirect_to posts_path, notice: 'Data successfully import.'
    end

    private
    def post_params
        params.require(:post).permit(:title, :description)
    end

end
