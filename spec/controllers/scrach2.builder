require 'rails_helper'

RSpec.describe MaterialsController, type: :controller do
  # before do
  #     @user = User.find_by(email: 'ahegde1@sheffield.ac.uk')
  #     sign_in @user
  # end
  # let!(:admin_user) { create(:admin_user) }
  context 'As an admin' do
    let!(:user) { FactoryBot.create(:admin_user) }
    specify 'I can read builds' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #index' do
    # it 'renders the index template' do
    #     get :index
    #     expect(response).to render_template(:index)
    # end

    it 'assigns all materials to @materials' do
      sign_in user
      materials = Material.all
      get :index
      expect(assigns(:materials)).to eq(materials)
    end
  end

  describe 'GET #show' do
    let(:material) { Material.create(name: 'Example Material') }

    it 'renders the show template' do
      get :show, params: { id: material.id }
      expect(response).to render_template(:show)
    end

    it 'assigns the requested material to @material' do
      get :show, params: { id: material.id }
      expect(assigns(:material)).to eq(material)
    end
  end

  describe 'POST #create' do
    it 'creates a new material' do
      expect do
        post :create, params: { material: { name: 'New Material' } }
      end.to change(Material, :count).by(1)
    end

    it 'redirects to the created material' do
      post :create, params: { material: { name: 'New Material' } }
      expect(response).to redirect_to(Material.last)
    end
  end

  describe 'PATCH #update' do
    let(:material) { Material.create(name: 'Example Material') }

    it 'updates the material' do
      patch :update, params: { id: material.id, material: { name: 'Updated Material' } }
      material.reload
      expect(material.name).to eq('Updated Material')
    end

    it 'redirects to the updated material' do
      patch :update, params: { id: material.id, material: { name: 'Updated Material' } }
      expect(response).to redirect_to(material)
    end
  end
end
