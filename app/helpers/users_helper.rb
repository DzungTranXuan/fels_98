module UsersHelper
  def is_owner? user
    current_user.present? && current_user.id == user.id
  end
end
