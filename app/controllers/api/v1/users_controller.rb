class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]

  def index
    filters = params[:filters] || {}
    @users = User.filter_by(filters).page(params[:page]).per(params[:per_page])

    render json: @users
  end

  # GET /api/v1/users/1
  def show
    render json: @user
  end

  # POST /api/v1/users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: e, status: :unprocessable_entity
  end

  # DELETE /api/v1/users/1
  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :name, :global_admin, :timezone, :receive_marketing, :external_id, skills: [])
  end

end
