class HomeController < ApplicationController
  include Authorization

  before_action :require_login, only: [:index, :admin]
  before_action :require_admin, only: [:admin]

  def index
  end

  def admin
  end
end
