class RegistrationsController < Devise::RegistrationsController
    
  def create
    @user = User.new(params.require(:user).permit(:username, :email, :password, :password_confirmation, :phone_number, :address, :pincode))
    if @user.save 
      sign_in(@user)
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
        flash[:notice] = "Your account as been updated"
        redirect_to @user
    else
        render 'edit'
    end
  end
end
