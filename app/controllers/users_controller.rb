class UsersController < ApplicationController
  # before_action :set_user, only: %i[ show edit update destroy ]

  # def index
  #  @users = User.all
  # end

  def show
    @user = User.find(params[:id])
  end

  # def new
  #  @user = User.new
  # end

  # def edit
  # end

  # def create
  # end

  # def update
  #  respond_to do |format|
  #    if @user.update(user_params)
  #      format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
  #      format.json { render :show, status: :ok, location: @user }
  #    else
  #      format.html { render :edit, status: :unprocessable_entity }
  #      format.json { render json: @user.errors, status: :unprocessable_entity }
  #    end
  #  end
  # end

  # def destroy
  #   @user.destroy!

  #   respond_to do |format|
  #     format.html { redirect_to users_url, notice: "User was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  private

  def user_params
    # ストロングパラメータで、名前とメールを受け取ることができるように設定
    params.require(:user).permit(:name, :email)
  end
end
