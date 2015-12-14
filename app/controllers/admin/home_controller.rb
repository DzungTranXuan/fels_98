class Admin::HomeController < ApplicationController
  include Authorization

  before_action :require_admin

  def index
  end
end