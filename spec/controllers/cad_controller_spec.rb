require 'rails_helper'

RSpec.describe CadsController, type: :controller do
  before do
    @user = User.find_by(email: 'ahegde1@sheffield.ac.uk')
    sign_in @user
  end
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      puts response.status
      puts response.body
      expect(response).to be_successful
    end
  end

  describe CadsController do
    let(:cad_file) { fixture_file_upload('spec/factories/files/CADS_test.pdf', 'application/pdf') }
    let(:cad) do
      cad = Cad.new(name: 'Test CAD', file_type: 'Part File', machineId: 'Scintilla (HSS)', file: cad_file)
      if cad.save
        cad
      else
        puts cad.errors.full_messages
        nil
      end
    end

    describe 'POST #create' do
      let(:cad) do
        Cad.create(
          name: 'Test CAD',
          file_type: 'Part File',
          machineId: 1,
          createdBy: 1,
          modifiedBy: 1,
          file: fixture_file_upload('spec/factories/files/CADS_test.pdf', 'application/pdf')
        )
      end

      it 'creates a new CAD' do
        expect do
          post :create,
               params: { cad: { name: 'Test CAD', file_type: 'Part File', machineId: 1, createdBy: 1, modifiedBy: 1,
                                file: fixture_file_upload('spec/factories/files/CADS_test.pdf', 'application/pdf') } }
        end.to change(Cad, :count).by(1)
      end

      it 'redirects to the new CAD' do
        post :create,
             params: { cad: { name: 'Test CAD', file_type: 'Part File', machineId: 1, createdBy: 1, modifiedBy: 1,
                              file: fixture_file_upload('spec/factories/files/CADS_test.pdf', 'application/pdf') } }
        expect(response).to redirect_to(Cad.last)
      end

      it 'displays a success message after creating the CAD' do
        post :create,
             params: { cad: { name: 'Test CAD', file_type: 'Part File', machineId: 1, createdBy: 1, modifiedBy: 1,
                              file: fixture_file_upload('spec/factories/files/CADS_test.pdf', 'application/pdf') } }
        expect(flash[:notice]).to eq('Cad was successfully created.')
      end
    end

    describe 'GET #show' do
      let(:cad) do
        Cad.create!(
          name: 'Test CAD',
          file_type: 'Part File',
          machineId: 1,
          createdBy: 1,
          modifiedBy: 1,
          file: fixture_file_upload('spec/factories/files/CADS_test.pdf', 'application/pdf')
        )
      end

      it 'returns a success response' do
        get :show, params: { id: cad.id }
        expect(response).to be_successful
      end
    end

    describe 'PUT #update' do
      let(:cad) do
        Cad.create(
          name: 'Test CAD',
          file_type: 'Part File',
          machineId: 1,
          createdBy: 1,
          modifiedBy: 1,
          file: fixture_file_upload('spec/factories/files/CADS_test.pdf', 'application/pdf')
        )
      end

      it 'updates the CAD' do
        put :update, params: { id: cad.id, cad: { name: 'Updated CAD' } }
        cad.reload
        expect(cad.name).to eq('Updated CAD')
      end

      it 'redirects to the updated CAD' do
        put :update, params: { id: cad.id, cad: { name: 'Updated CAD' } }
        expect(response).to redirect_to(cad)
      end

      it 'displays a success message after updating the CAD' do
        put :update, params: { id: cad.id, cad: { name: 'Updated CAD' } }
        expect(flash[:notice]).to eq('Cad was successfully updated.')
      end
    end
  end
end
