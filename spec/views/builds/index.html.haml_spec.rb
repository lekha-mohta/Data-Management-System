# require 'rails_helper'

# RSpec.describe 'builds/index', type: :view do
#   before(:each) do
#     @builds = assign(:builds, Build.all)
#   end

#   it "renders build index page correctly" do
#     render
#     expect(rendered).to match(/Name/)
#     expect(rendered).to match(/Project/)
#     expect(rendered).to match(/Machine/)
#     expect(rendered).to match(/Material/)
#     expect(rendered).to match(/Avg UTS/)
#     expect(rendered).to match(/Avg Modulus/)
#     expect(rendered).to match(/Avg EaB/)
#     expect(rendered).to match(/Created By/)
#     expect(rendered).to match(/Modified By/)
#     assert_select "table"
#   end
# end

# RSpec.describe 'Index page', type: :system do
#   before do
#     @user = User.find_by(email: 'ahegde1@sheffield.ac.uk')
#     login_as(@user, scope: :user)

#     @builds = Build.all

#     #driven_by(:selenium_chrome_headless)
#   end

#   # it 'filters by name' do
#   #   visit 'builds/'
#   #   fill_in 'name', with: @builds.first.name
#   #   click_button 'Apply Filters'

#   #   expect(page).to have_content(@builds.first.name)
#   # end

#   it 'filters by material' do
#     visit 'builds/'
#     select @builds.first.material.name, from: 'materialId'
#     click_button 'Apply Filters'

#     expect(page).to have_content(@builds.first.material.name)
#   end

#   it 'filters by machine' do
#     visit 'builds/'
#     select @builds.first.machine.name, from: 'machineId'
#     click_button 'Apply Filters'

#     expect(page).to have_content(@builds.first.machine.name)
#   end

#   it 'filters by project' do
#     visit 'builds/'
#     select @builds.first.build_project.name, from: 'projectId'
#     click_button 'Apply Filters'

#     expect(page).to have_content(@builds.first.build_project.name)
#   end

#   # it 'filters by created by' do
#   #   visit 'builds/'
#   #   fill_in 'createdBy', with: @builds.first.created_by.givenname
#   #   click_button 'Apply Filters'

#   #   expect(page).to have_content(@builds.first.created_by.givenname)
#   # end

#   # it 'filters by modified by' do
#   #   visit 'builds/'
#   #   fill_in 'modifiedBy', with: @builds.first.modified_by.givenname
#   #   click_button 'Apply Filters'

#   #   expect(page).to have_content(@builds.first.modified_by.givenname)
#   # end

#   # it 'filters by creation date' do
#   #   visit 'builds/'

#   #   # Fill in the minimum creation date
#   #   fill_in 'created_at_min', with: '01/01/1900'
#   #   click_button 'Apply Filters'
#   #   expect(page).to have_content(@builds.first.name)

#   #   # Fill in the maximum creation date
#   #   fill_in 'created_at_max', with: '01/01/2100'
#   #   click_button 'Apply Filters'
#   #   expect(page).to_not have_content(@builds.first.name)

#   #   # Clear Filters
#   #   click_link 'Clear Filters'

#   #   # Fill in both minimum and maximum creation date
#   #   fill_in 'created_at_min', with: '01/01/1900'
#   #   fill_in 'created_at_max', with: '01/01/2100'
#   #   click_button 'Apply Filters'
#   #   expect(page).to have_content(@builds.first.name)

#   #   # Clear Filters
#   #   click_link 'Clear Filters'

#   #   # Fill in maximum date less than minimum date
#   #   fill_in 'created_at_min', with: '01/01/2100'
#   #   fill_in 'created_at_max', with: '01/01/1900'
#   #   click_button 'Apply Filters'
#   #   expect(page).to_not have_content(@builds.first.name)
#   # end

#   # it 'filters by update date' do
#   #   visit 'builds/'

#   #   # Fill in the minimum update date
#   #   fill_in 'updated_at_min', with: '01/01/1900'
#   #   click_button 'Apply Filters'
#   #   expect(page).to have_content(@builds.first.name)

#   #   # Fill in the maximum update date
#   #   fill_in 'updated_at_max', with: '01/01/2100'
#   #   click_button 'Apply Filters'
#   #   expect(page).to_not have_content(@builds.first.name)

#   #   # Clear Filters
#   #   click_link 'Clear Filters'

#   #   # Fill in both minimum and maximum update date
#   #   fill_in 'updated_at_min', with: '01/01/1900'
#   #   fill_in 'updated_at_max', with: '01/01/2100'
#   #   click_button 'Apply Filters'
#   #   expect(page).to have_content(@builds.first.name)

#   #   # Clear Filters
#   #   click_link 'Clear Filters'

#   #   # Fill in maximum date less than minimum date
#   #   fill_in 'updated_at_min', with: '01/01/2100'
#   #   fill_in 'updated_at_max', with: '01/01/1900'
#   #   click_button 'Apply Filters'
#   #   expect(page).to_not have_content(@builds.first.name)
#   # end

#   scenario 'User clicks on New Build button' do
#     visit builds_path

#     click_on 'New Build'

#     expect(page).to have_current_path(new_build_path)
#   end
# end
