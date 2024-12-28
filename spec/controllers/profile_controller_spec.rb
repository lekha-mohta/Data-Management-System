require 'rails_helper'

RSpec.describe ProfileController, type: :controller do
  describe 'GET #index' do
    before do
      @user = User.find_by(email: 'ahegde1@sheffield.ac.uk')
      sign_in @user
    end

    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end
end
