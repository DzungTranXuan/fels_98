module Authorization
  def require_login
    if !user_signed_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_user_session_path
    end
  end

  def require_ownership user_id
    if current_user.blank? || current_user.id != user_id
      head 403
    end
  end
end