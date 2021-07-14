class ApplicationController < ActionController::Base
  before_action :authorize
  before_action :set_i18n_locale

  protected

  def authorize
    return if User.find_by(id: session[:user_id])

    redirect_to login_url, notice: 'Please log in'
  end

  def set_i18n_locale
    I18n.locale = if params[:locale] && I18n.available_locales.map(&:to_s).include?(params[:locale])
                    params[:locale]
                  else
                    I18n.default_locale
                  end
  end
end
