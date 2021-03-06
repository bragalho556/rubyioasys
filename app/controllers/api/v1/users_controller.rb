 class Api::V1::UsersController < Api::V1::BaseController
    before_action :authenticate_user!, except: [:create, :reset_password]
    before_action :load_resource, except: [:create, :reset_password]

    # CRUDs
    def create
      @user = User.create!(sign_up_params)
      bypass_authenticate(@user)
      render json: @user
    end

    def update
      authorize @user
      @user.update!(update_params)
      render json: @user
    end

    def show
      authorize @user
      render json: @user
    end

    # Custom actions
    def password
      authorize @user
      @user.update_with_password!(password_params)
    end

    def reset_password
      params.require(:email)
      User.reset_password(params[:email])
      # No Content
    end

    def register_device
      require_parameters([:device_id, :device_os])
      authorize @user
      current_user.register_device(request.headers["client"], params[:device_id], params[:device_os])
      # No Content
    end

    ###
    private

      def sign_up_params
        require_parameters([:email, :password])
        params.permit(:email, :password)
      end

      def update_params
        params.permit(:email)
      end

      def password_params
        require_parameters([:current_password, :password])
        params.permit(:current_password, :password, :password_confirmation)
      end

  end

