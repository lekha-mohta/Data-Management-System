require 'rails_helper'

RSpec.describe CadController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'creates a new CAD' do
      expect do
        post :create, params: { cad: { name: 'New CAD' } }
      end.to change(Cad, :count).by(1)
    end

    it 'redirects to the created CAD' do
      post :create, params: { cad: { name: 'New CAD' } }
      expect(response).to redirect_to(Cad.last)
    end
  end

  describe 'GET #show' do
    let(:cad) { Cad.create(name: 'Test CAD') }

    it 'returns a success response' do
      get :show, params: { id: cad.id }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    let(:cad) { Cad.create(name: 'Test CAD') }

    it 'updates the CAD' do
      put :update, params: { id: cad.id, cad: { name: 'Updated CAD' } }
      cad.reload
      expect(cad.name).to eq('Updated CAD')
    end

    it 'redirects to the updated CAD' do
      put :update, params: { id: cad.id, cad: { name: 'Updated CAD' } }
      expect(response).to redirect_to(cad)
    end
  end
end
