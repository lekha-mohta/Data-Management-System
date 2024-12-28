# Comment

class UsersController < ApplicationController
  before_action :set_user, only: %i[show update]

  authorize_resource

  # GET /users
  def index
    @users = User.all
    @users = apply_role_filter(@users, params[:role]) if params[:role].present?
    @users = apply_word_filter(@users, :givenname, params[:givenname]) if params[:givenname].present?
    @users = apply_word_filter(@users, :email, params[:email]) if params[:email].present?
  end

  # GET /users/1
  def show; end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render :index
    end
  end

  # Filter the materials by the given attribute and value
  def apply_word_filter(objects, attribute, value)
    objects.select do |object|
      object.send(attribute).downcase.include?(value.downcase)
    end
  end

  def apply_role_filter(objects, value)
    if value.downcase == 'any'
      objects
    else
      objects.select do |object|
        object.role.downcase == value.downcase
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:givenname, :email, :role)
  end
end
