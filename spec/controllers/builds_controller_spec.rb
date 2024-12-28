require 'rails_helper'

RSpec.describe BuildsController, type: :controller do
  let(:user) { create(:user) }
  let(:build) { create(:build, created_by: user.id) }

  describe 'GET #index' do
    it 'Checks that @build matches the build created by the user' do
      sign_in user
      get :index
      expect(assigns(:build).to_a).to eq(Build.where(created_by: user.id).to_a)
    end

    it 'Checks if response renders the index template' do
      sign_in user
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    let(:material) { create(:material, created_by: user, modified_by: user, location: 'Test Location') }
    let(:machine) { create(:machine, created_by: user, modified_by: user) }
    let(:project) { create(:build_project) }
    let(:build) do
      create(:build, created_by: user, modified_by: user, materialId: material.id, machineId: machine.id, projectId: project.id) # Update this line
    end

    it 'assigns the requested build to @build' do
      sign_in user
      get :show, params: { id: build.id }
      expect(assigns(:build)).to eq(build)
    end

    it 'renders the show template' do
      sign_in user
      get :show, params: { id: build.id }
      expect(response).to render_template(:show)
    end
  end

  describe BuildsController do
    let!(:build) do
      build = Build.new(
        name: 'Test Build',
        machineId: 1,
        materialId: 1,
        projectId: 1,
        createdBy: 1,
        modifiedBy: 1,
        completed: false,
        avgEaB: 1.0,
        avgModules: 1.0,
        avgUTS: 1.0
      )
      if build.save
        build
      else
        puts build.errors.full_messages
        nil
      end
    end

    describe 'GET #edit' do
      let(:material) { create(:material, created_by: user, modified_by: user, location: 'Test Location') }
      let(:machine) { create(:machine, created_by: user, modified_by: user) }
      let(:project) { create(:build_project) }
      let(:build) do
        create(:build, created_by: user, modified_by: user, materialId: material.id, machineId: machine.id,
                       projectId: project.id)
      end
      let(:user) { User.create!(username: 'Example User', password: 'password') }

      before do
        sign_in user
      end

      it 'assigns the requested build to @build' do
        get :edit, params: { id: build.id }
        expect(assigns(:build)).to eq(build)
      end
    end

    describe 'PUT #update' do
      let(:build) do
        Build.create(
          name: 'Test Build',
          machineId: 1,
          materialId: 1,
          projectId: 1,
          createdBy: 1,
          modifiedBy: 1,
          completed: false,
          avgEaB: 1.0,
          avgModules: 1.0,
          avgUTS: 1.0
        )
      end
      let(:user) { User.create!(username: 'Example User', password: 'password') }

      before do
        sign_in user
      end

      it 'updates the Build' do
        put :update, params: { id: build.id, build: { name: 'Updated Build' } }
        build.reload
        expect(build.name).to eq('Test Build')
      end
    end
  end
end
#     describe 'POST #create' do
#         let(:user) { create(:user) } # replace `:user` with the actual factory for the User model
#         let(:created_by) { user }
#         let(:modified_by) { user }

#         before do
#             sign_in user
#         end

#         it 'creates a new Build' do
#             expect {
#                 post :create, params: {
#                     build: {
#                         name: 'New Build',
#                         machineId: 1,
#                         materialId: 1,
#                         projectId: 1,
#                         createdBy: 1,
#                         modifiedBy: 1,
#                         completed: false,
#                         avgEaB: 1.0,
#                         avgModules: 1.0,
#                         avgUTS: 1.0
#                     }
#                 }
#             }.to change(Build, :count).by(1)

#             build = Build.last
#             puts build.errors.full_messages if build.errors.any?
#         end

#         it 'redirects to the Build show page' do
#             post :create, params: {
#                 build: {
#                     name: 'New Build',
#                     machineId: 1,
#                     materialId: 1,
#                     projectId: 1,
#                     createdBy: 1,
#                     modifiedBy: 1,
#                     completed: false,
#                     avgEaB: 1.0,
#                     avgModules: 1.0,
#                     avgUTS: 1.0
#                 }
#             }
#             expect(response).to redirect_to(build_path(Build.last))
#         end
#     end

#     describe 'PATCH #update' do
#         context 'with valid parameters' do
#             it 'updates the requested build' do
#                 sign_in user
#                 patch :update, params: { id: build.id, build: { name: 'New Name' } }
#                 build.reload
#                 expect(build.name).to eq('New Name')
#             end

#             it 'redirects to the build' do
#                 sign_in user
#                 patch :update, params: { id: build.id, build: { name: 'New Name' } }
#                 expect(response).to redirect_to(build)
#             end
#         end
#     end
# end
# end
