# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :authorize_user, only: %i[show show_group_users]
  before_action :authorize_owner, only: %i[edit update destroy add_group_users delete_group_user]

  def index
    @groups = current_user.groups
  end

  def show; end

  def new
    @group = Group.new
  end

  def edit; end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id

    @group.users << User.where(id: current_user.id)

    respond_to do |format|
      if @group.save
        format.html { redirect_to group_url(@group), notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to group_url(@group), notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group.destroy!

    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def new_users;end


  def add_users
    user_ids = params[:user_ids]

    @group.users << User.where(id: user_ids)

    respond_to do |format|
      format.html { redirect_to group_url(@group), notice: 'Users were successfully added to the group.' }
      format.json { head :no_content }
    end
  end

  def show_users;end

  def delete_user
    user_id = params[:user_id]

    @group.users.delete(User.find(user_id))

    respond_to do |format|
      format.html { redirect_to group_url(@group), notice: 'User was successfully removed from the group.' }
      format.json { head :no_content }
    end
  end

  private

  def authorize_owner
    return if @group.owner_id == current_user.id

    render json: { error: 'Not an Owner' }, status: :unauthorized
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :single_user)
  end

  def authorize_user
    return if @group.users.include?(current_user)

    render json: { error: 'Not Authorized' }, status: :unauthorized
  end
end
