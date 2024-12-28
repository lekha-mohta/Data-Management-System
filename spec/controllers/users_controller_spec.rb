require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    before do
      @user = User.find_by(email: 'ahegde1@sheffield.ac.uk')
      sign_in @user
    end

    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'filters users by given name' do
      get :index, params: { givenname: 'Atri' }
      expect(assigns(:users)).to all(have_attributes(givenname: 'Atri'))
    end

    it 'filters users by role' do
      get :index, params: { role: 'admin' }
      expect(assigns(:users)).to all(have_attributes(role: 'admin'))
    end
  end
end
