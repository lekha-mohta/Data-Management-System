require 'rails_helper'

RSpec.describe 'groups/index', type: :view do
  before(:each) do
    assign(:groups, [
             Group.create!(
               name: 'Group 1',
               description: 'Description'
             ),
             Group.create!(
               name: 'Group 2',
               description: 'Description'
             )
           ])
  end

  it 'renders a list of groups' do
    render
    assert_select 'tr>td', text: 'Group 1'.to_s, count: 1
    assert_select 'tr>td', text: 'Group 2'.to_s, count: 1
  end
end
