class Api::V1::Authentication::SessionsController < Api::V1::BaseController
  before_action :authenticate_user!, only: [:destroy]


  def create
    require_parameters([:auth, :password])
    request.headers["resource-type"] = params[:action]
    sign_in(params[:auth], params[:password], { device_id: params[:device_id], device_os: params[:device_os] })
    render json: current_user
  end

  def destroy
    sign_out
  end

  # alias methods
  alias_method :user, :create


end
