class AccessController < ApplicationController
  before_action :confirm_logged_in, except: [:login, :attempt_login, :logout]

  def menu
    @username = session[:username]
  end

  def login
    @page_title = 'login'
  end

  def attempt_login
    if params[:name].present? && params[:password].present?
      found_user = User.where(name: params[:name]).first
      authorized_user = found_user.authenticate(params[:password]) if found_user
    end

    if authorized_user
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.name
      flash[:notice] = 'logged in.'
      redirect_to(admin_path)
    else
      flash.now[:notice] = 'invalid name/password combination.'
      render('login')
    end
  end

  def logout
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = 'logged out'
    redirect_to(access_login_path)
  end
end
