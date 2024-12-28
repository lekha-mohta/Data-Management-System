### THIS SHOULD BE ADMIN ONLY ROUTE
class GroupUsersController < ApplicationController
  before_action :set_group_user, only: %i[show edit update destroy]

  authorize_resource

  # GET /group_users
  def index
    @group_users = GroupUser.all
  end

  # GET /group_users/1
  def show; end

  # GET /group_users/new
  def new
    @group = Group.find(params[:format])

    # Show all group users at the top
    @group_users = @group.group_users
    @group_users = apply_word_filter(@group_users, :email, params[:email], group_users: true) if params[:email].present?

    # Show remaining users
    @users = User.all - @group_users.map(&:user)
    @users = apply_word_filter(@users, :email, params[:email]) if params[:email].present?
  end

  # GET /group_users/1/edit
  def edit; end

  # POST /group_users
  def create
    @group_user = GroupUser.new(group_user_params)

    if @group_user.save
      redirect_to new_group_user_path(format: @group_user.groupId), notice: 'User was successfully added to Group.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /group_users/1
  def update
    if @group_user.update(group_user_params)
      redirect_to @group_user, notice: 'Group user was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /group_users/1
  def destroy
    @group_user.destroy
    redirect_to new_group_user_path(@group_user.group), notice: 'User was successfully removed from group.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group_user
    @group_user = GroupUser.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_user_params
    params.require(:group_user).permit(:groupId, :userId)
  end

  # Filter the materials by the given attribute and value
  def apply_word_filter(objects, attribute, value, group_users: false)
    objects.select do |object|
      if group_users
        object.user.send(attribute).downcase.include?(value.downcase)
      else
        object.send(attribute).downcase.include?(value.downcase)
      end
    end
  end
end
