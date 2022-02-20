class SessionsController < ApplicationController
  
  include EmailHelper
	def new
  end

   def create

    user = params[:session][:name]

    if isEmail(user)

    	user = User.find_by_email(params[:session][:email].downcase)

    else
    	
    user = User.find_by_name(params[:session][:name].downcase)
   
    end

    if user && user.authenticate(params[:session][:password])
      
      sign_in user
      redirect_to user



    else
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end


  def destroy
  	sign_out
    redirect_to root_url
  end	
end
