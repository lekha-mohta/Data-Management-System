require 'rails_helper'

RSpec.describe 'profile/index', type: :view do
  before do
    @user = User.find_by(email: 'ahegde1@sheffield.ac.uk')
    allow(view).to receive(:current_user).and_return(@user)
    login_as(@user, scope: :user)
  end

  it 'renders a list of profiles' do
    render
    expect(rendered).to have_content('ahegde1@sheffield.ac.uk')
  end
end
