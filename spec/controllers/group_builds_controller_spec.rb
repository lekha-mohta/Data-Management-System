require 'rails_helper'

RSpec.describe GroupBuildsController, type: :controller do
  let(:group_build) { FactoryBot.create(:group_build) }
  before do
    @user = User.find_by(email: 'ahegde1@sheffield.ac.uk')
    sign_in @user
  end

  describe 'when the user is an admin' do
    it 'renders the index template (GET /group_builds)' do
      get :index
      expect(response).to render_template(:index)
      expect(assigns(:group_builds)).to eq(GroupBuild.all)
    end

    it 'renders the show template (GET /group_builds/1)' do
      get :show, params: { id: group_build.id }
      expect(response).to render_template(:show)
    end

    it 'renders the "new" template (GET /group_builds/new)' do
      get :new, params: { format: group_build.id }
      expect(response).to render_template(:new)
      expect(assigns(:group)).to eq(Group.find(group_build.id))
      expect(assigns(:group_builds)).to eq(Group.find(group_build.id).group_builds)
      expect(assigns(:builds)).to eq(Build.all - Group.find(group_build.id).group_builds.map(&:build))
    end

    it 'renders the "edit" template (GET /group_builds/1/edit)' do
      get :edit, params: { id: group_build.id }
      expect(response).to render_template(:edit)
    end

    it 'renders the "edit" template (GET /group_builds/1/edit)' do
      get :edit, params: { id: group_build.id }
      expect(response).to render_template(:edit)
    end

    it 'creates a new GroupBuild (POST /group_builds)' do
      expect do
        post :create, params: { group_build: { groupId: 1, buildId: 2 } }
      end.to change(GroupBuild, :count).by(1)
    end

    # TODO: group_builds_controller_spec def update
    # let(:new_group_build) { FactoryBot.build(:group_build) }
    # let(:valid_params) { { group_build: { groupId: new_group_build.id, buildId: FactoryBot.build(:build).id } } }
    # it 'updates the group build' do
    #   patch :update, params: { id: group_build.id, group_build: valid_params[:group_build] }
    #   puts response.body # Output the response body for debugging
    #   expect(response).to redirect_to(group_build)
    #   expect(flash[:notice]).to eq('Group build was successfully updated.')
    # end

    # TODO: group_builds_controller_spec def destroy
    # it 'destroys the group build' do
    #   expect {
    #     delete :destroy, params: { id: group_build.id }
    #   }.to change(GroupBuild, :count).by(-1)
    # end
  end
end
