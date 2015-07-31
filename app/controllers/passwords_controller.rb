class PasswordsController < ApplicationController
  before_filter :authenticate_user!

  def edit

  end


  def update

    respond_to do |format|
        format.html {
          if validate_and_update_password(params[:current_password], params[:password], params[:password_confirmation])
            redirect_to new_admin_path, notice: "Password successfully changed"
          else
            render 'edit'
          end
        }
        format.json { head :no_content }
        format.js { render 'update' }
    end

  end

  def validate_and_update_password(current_password, password, password_confirmation)
    if !current_user.valid_password?(current_password)
      return "Invalid Password"
    elsif password && password_confirmation
      return "Fill in both password and password confirmation"
    elsif password != password_confirmation
      return "passwords don't match"
    elsif password.length < 8
      return "password must be at least 8 characters"
    elsif
      current_user.password = params[:user][:new_password]
      current_user.password_confirmation = params[:user][:password_confirmation]
      current_user.save
      return ""
    end
  end

end
