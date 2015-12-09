class HomeController < ApplicationController
  include Authorization

  before_action :require_login, only: [:index]

  def index
  end
end
