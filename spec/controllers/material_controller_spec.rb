require 'rails_helper'

RSpec.describe MaterialsController, type: :controller do
  before do
    @user = User.find_by(email: 'ahegde1@sheffield.ac.uk')
    sign_in @user
  end
  let!(:admin_user) { create(:admin_user) }
  context 'As an admin' do
    let!(:user) { FactoryBot.create(:admin_user) }
    specify 'I can read builds' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #index' do
    it 'assigns all materials to @materials' do
      materials = Material.all.to_a
      get :index
      expect(assigns(:materials).to_a).to eq(materials)
    end
  end

  describe 'GET #show' do
    let(:user) { User.create!(username: 'Example User', password: 'password') }
    let(:material) do
      Material.create!(
        name: 'Example Material',
        createdBy: user.id,
        modifiedBy: user.id,
        quantity: 10,
        location: 'Example Location'
      )
    end

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
    it 'creates a new Material' do
      expect do
        post :create, params: {
          material: {
            name: 'Test Material',
            createdBy: 1,
            modifiedBy: 1,
            quantity: 10,
            location: 'Example Location'
          }
        }
      end.to change(Material, :count).by(1)
    end

    it 'redirects to the Material show page' do
      post :create, params: {
        material: {
          name: 'Test Material',
          createdBy: 1,
          modifiedBy: 1,
          quantity: 10,
          location: 'Example Location'
        }
      }
      expect(response).to redirect_to(material_path(Material.last))
    end
  end

  describe 'PATCH #update' do
    let(:user) { User.create!(username: 'Example User', password: 'password') }
    let(:material) do
      Material.create!(
        name: 'Example Material',
        createdBy: user.id,
        modifiedBy: user.id,
        quantity: 10,
        location: 'Example Location'
      )
    end

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
