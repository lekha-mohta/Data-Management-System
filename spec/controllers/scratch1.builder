require 'rails_helper'

RSpec.describe BuildsController, type: :controller do
  let(:user) { create(:user) }
  let(:build) { create(:build, created_by: user.id) }

  describe 'GET #index' do
    it 'assigns accessible builds to @build' do
      sign_in user
      get :index
      expect(assigns(:build)).to eq(Build.where(created_by: user.id))
    end

    it 'renders the index template' do
      sign_in user
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
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

  describe 'GET #new' do
    it 'renders the new template' do
      sign_in user
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested build to @build' do
      sign_in user
      get :edit, params: { id: build.id }
      expect(assigns(:build)).to eq(build)
    end

    it 'renders the edit template' do
      sign_in user
      get :edit, params: { id: build.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new build' do
        sign_in user
        expect do
          post :create, params: { build: attributes_for(:build) }
        end.to change(Build, :count).by(1)
      end

      it 'redirects to the created build' do
        sign_in user
        post :create, params: { build: attributes_for(:build) }
        expect(response).to redirect_to(Build.last)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new build' do
        sign_in user
        expect do
          post :create, params: { build: attributes_for(:build, name: nil) }
        end.to_not change(Build, :count)
      end

      it 'renders the new template with unprocessable entity status' do
        sign_in user
        post :create, params: { build: attributes_for(:build, name: nil) }
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'updates the requested build' do
        sign_in user
        patch :update, params: { id: build.id, build: { name: 'New Name' } }
        build.reload
        expect(build.name).to eq('New Name')
      end

      it 'redirects to the build' do
        sign_in user
        patch :update, params: { id: build.id, build: { name: 'New Name' } }
        expect(response).to redirect_to(build)
      end
    end
  end
end
