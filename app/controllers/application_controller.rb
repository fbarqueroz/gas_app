class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_current_account

  private

  def set_current_account
    @current_account = current_user&.account
  end

  def current_account
    @current_account
  end
  helper_method :current_account
end
