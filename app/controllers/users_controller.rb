class UsersController < ApplicationController
    before_action :authorize, only: [:index, :new, :edit,:update]
    # before_action :redirect_cancel, only: [:create, :update]
    def new
        @user = User.new
    end
    def index
        if params[:search]           
            @users = User.all.where("id != ?", current_user.id).search(params[:search]).paginate(page: params[:page], per_page: 5)
        else           
           # @users =  User.all.where("id NOT IN(?)", current_user.id)
           @users = User.all.where("id != ?", current_user.id).paginate(page: params[:page], per_page: 5)
         end 
    end

    def show
        p "SHOW"
        @user = User.find(params[:id])
    end

    def register
        @user=User.new
    end

    def confirm
        p "Confirm user"   
        @user = User.new(user_params)
        p "User data #{@user.inspect}"
        render "confirm_user", status: :unprocessable_entity
    end
    def create
        p "Create user"  
        @user = User.new(user_params)
        p "User data #{user_params.inspect}"
        # store all emails in lowercase to avoid duplicates and case-sensitive login errors:
        @user.email.downcase!
    
        if @user.save
        # If user saves in the db successfully:
        flash[:notice] = "User created successfully!"
        redirect_to users_path
        else
        # If user fails model validation - probably a bad password or duplicate email:
        flash.now.alert = "Oops, couldn't create user. Please make sure you are using a valid email and password and try again."
        render :new
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def confirm_update
        @user = User.new(user_params)  
        p "UPDATE_Confirm_USER"
        render "confirm_user_update" , status: :unprocessable_entity
    end

    def update
        p 'Update user '
        user = User.find(params[:id])
        user.updated_user_id = session[:user_id]
        if user.update
            flash[:notice] = "User updated successfully!"
            redirect_to posts_path
        else        
            flash.now.alert = "Oops, couldn't create post. Please try again."
            render :new, status: :unprocessable_entity
        end         
        redirect_to users_path
    end

    def destroy
        user = User.find(params[:id])
        user.destroy
        redirect_to user_path
    end  

    def confirmEmail
        @user = User.find(params[:id])
        
    end

    def changePassword
    end
    def passwordChange
    end
    def change_password
    @user = User.find(session[:user_id])
    p "user data #{@user.inspect}"
    current_password = params[:current_password]
    p "current password #{current_password.inspect}"
    user = User.authenticate(@user.email, current_password)
    p "user authenticate  #{user.inspect}"
        if @user && user
            # @user.update.password = params[:new_password]
            # new_password = params[:password]
            # @user.update(new_password)
            user.update_attribute(password: params[:current_password])
            flash[:notice] = "Password successfully changed!"
            redirect_to user_path(session[:user_id])
        else
            flash[:notice] = "Your old password was incorrect. Please try again."
            
            redirect_to user_path(session[:user_id])
        end
    end

    private
        def change_password_params
            params.require(:user).permit(:old_password, :password, :password_confirmation)
        end

        def user_params
            params.require(:user).permit(:name, :email, :phone, :address, :date_of_birth, :profile_photo, :password, :password_confirmation)
        end

    
end
