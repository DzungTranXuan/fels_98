module Authorization
  def require_login
    if !user_signed_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_user_session_path
    end
  end
end