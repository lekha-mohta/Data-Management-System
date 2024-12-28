# require 'rails_helper'

# RSpec.describe 'cads/index', type: :view do
#   before(:each) do
#     @users = assign(:users, User.all)
#     @builds = assign(:builds, Build.all)
#     @cads = assign(:cads, Cad.all)
#     @machines = assign(:machines, Machine.all)
#     @materials = assign(:materials, Material.all)
#   end

#   it "renders cad index page correctly" do
#     render
#     expect(rendered).to match(/name/)
#     expect(rendered).to match(/file_type/)
#     assert_select "table"
#   end
# end

# RSpec.describe 'Index page', type: :system do
#   before do
#     @user = User.find_by(email: 'ahegde1@sheffield.ac.uk')
#     login_as(@user, scope: :user)

#     @cads = Cad.all

#     driven_by(:selenium_chrome_headless)

#   end

#   it 'filters by name' do
#     visit 'cads/'
#     fill_in 'name', with: @cads.first.name
#     click_button 'Apply Filters'

#     expect(page).to have_content(@cads.first.name)
#     @cads[1..-1].each do |cad|
#       expect(page).not_to have_content(cad.name)
#     end
#   end

#   it 'filters by file_type' do
#     visit 'cads/'
#     fill_in 'file_type', with: @cads.first.file_type
#     click_button 'Apply Filters'
#     expect(page).to have_content(@cads.first.file_type)

#     fill_in 'file_type', with: 'not_a_real_file_type'
#     click_button 'Apply Filters'

#     @cads.each do |cad|
#       expect(page).not_to have_content(cad.file_type)
#     end
#   end

#   it 'filters by file_type' do
#     visit 'cads/'
#     fill_in 'file_type', with: @cads.first.file_type
#     click_button 'Apply Filters'
#     expect(page).to have_content(@cads.first.file_type)

#     fill_in 'file_type', with: 'not_a_real_file_type'
#     click_button 'Apply Filters'

#     @cads.each do |cad|
#       expect(page).not_to have_content(cad.file_type)
#     end
#   end

#   it 'filters by createdBy' do
#     visit 'cads/'
#     fill_in 'createdBy', with: @cads.first.createdBy
#     click_button 'Apply Filters'
#     expect(page).to have_content(@cads.first.createdBy)

#     fill_in 'createdBy', with: 'not_a_real_creator'
#     click_button 'Apply Filters'

#     @cads.each do |cad|
#       expect(page).not_to have_content(cad.createdBy)
#     end
#   end

#   it 'filters by modifiedBy' do
#     visit 'cads/'
#     fill_in 'modifiedBy', with: @cads.first.modifiedBy
#     click_button 'Apply Filters'
#     expect(page).to have_content(@cads.first.modifiedBy)

#     fill_in 'modifiedBy', with: 'not_a_real_modifier'
#     click_button 'Apply Filters'

#     @cads.each do |cad|
#       expect(page).not_to have_content(cad.modifiedBy)
#     end
#   end

#   it 'filters by archived' do
#     visit 'cads/'
#     select 'Yes', from: 'archived'
#     click_button 'Apply Filters'
#     expect(page).to_not have_content('false')

#     select 'No', from: 'archived'
#     click_button 'Apply Filters'
#     expect(page).to_not have_content('true')
#   end

#   it 'filters by created_at' do
#     visit 'cads/'

#     # all cads created after 1900
#     fill_in 'created_at_min', with: '0101900'
#     click_button 'Apply Filters'
#     expect(page).to have_content(@cads.first.name)

#     # all cads created after 2100
#     fill_in 'created_at_min', with: "01012100"
#     click_button 'Apply Filters'
#     expect(page).to_not have_content(@cads.first.name)

#     click_link 'Clear Filters'

#     # all cads created before 2100
#     fill_in 'created_at_max', with: "01012100"
#     click_button 'Apply Filters'
#     expect(page).to have_content(@cads.first.name)

#     # all cads created before 1900
#     fill_in 'created_at_max', with: "01011900"
#     click_button 'Apply Filters'
#     expect(page).to_not have_content(@cads.first.name)

#     click_link 'Clear Filters'

#     # all cads created between 1900 and 2100
#     fill_in 'created_at_max', with: "01012100"
#     fill_in 'created_at_min', with: "01011900"
#     click_button 'Apply Filters'
#     expect(page).to have_content(@cads.first.name)

#     click_link 'Clear Filters'

#     # max date of 1900 and min date of 2100
#     fill_in 'created_at_max', with: "01011900"
#     fill_in 'created_at_min', with: "01012100"
#     click_button 'Apply Filters'
#     expect(page).to_not have_content(@cads.first.name)
#   end

#   it 'filters by updated_at' do
#     visit 'cads/'

#     # all cads updated after 1900
#     fill_in 'updated_at_min', with: '0101900'
#     click_button 'Apply Filters'
#     expect(page).to have_content(@cads.first.name)

#     # all cads updated after 2100
#     fill_in 'updated_at_min', with: "01012100"
#     click_button 'Apply Filters'
#     expect(page).to_not have_content(@cads.first.name)

#     click_link 'Clear Filters'

#     # all cads updated before 2100
#     fill_in 'updated_at_max', with: "01012100"
#     click_button 'Apply Filters'
#     expect(page).to have_content(@cads.first.name)

#     # all cads updated before 1900
#     fill_in 'updated_at_max', with: "01011900"
#     click_button 'Apply Filters'
#     expect(page).to_not have_content(@cads.first.name)

#     click_link 'Clear Filters'

#     # all cads updated between 1900 and 2100
#     fill_in 'updated_at_max', with: "01012100"
#     fill_in 'updated_at_min', with: "01011900"
#     click_button 'Apply Filters'
#     expect(page).to have_content(@cads.first.name)

#     click_link 'Clear Filters'

#     # max date of 1900 and min date of 2100
#     fill_in 'updated_at_max', with: "01011900"
#     fill_in 'updated_at_min', with: "01012100"
#     click_button 'Apply Filters'
#     expect(page).to_not have_content(@cads.first.name)
#   end

#   scenario 'User clicks on New CAD button' do
#     visit cads_path

#     click_on 'New CAD'

#     expect(page).to have_current_path(new_cad_path)
#   end

#   #TODO
#   # it 'sorts by name' do
#   # it 'sorts by file_type' do
#   # it 'sorts by createdBy' do
#   # it 'sorts by modifiedBy' do
#   # scenario 'User clicks on Show button' do
#   # scenario 'User applies many filters at once' do
#   # add updated_at and created_at to the cads table

# end
