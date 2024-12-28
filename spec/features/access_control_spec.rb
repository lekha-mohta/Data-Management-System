require 'rails_helper'
# Access Control being tested
# user [read: 1)Build 2)Cad 3)Material 4)Machine]
# student&staff [user + create&update 1)Build 2)cad 3)Material]
# admin [staff + read&create&update 1)Machine 2)Group 3)User]

describe 'Creating materials' do
  before do
    login_as user
  end

  context 'As a user' do
    let!(:user) { FactoryBot.create(:user) }

    specify 'I can read builds' do
      visit '/builds'
      expect(page).to have_content 'Listing Builds'
      expect(page).to have_content 'No Builds found'
    end

    specify 'I can read cads' do
      visit '/cads'
      expect(page).to have_content 'Listing Designs'
    end

    specify 'I can read materials' do
      visit '/materials'
      expect(page).to have_content 'Listing Materials'
    end

    specify 'I can read machines' do
      visit '/machines'
      expect(page).to have_content 'Listing Machines'
    end

    specify 'I cannot create a new build' do
      visit '/builds'
      click_on 'New Build'
      expect(page).to have_content 'You are not authorized to access this page.'
    end

    specify 'I cannot create a new cad' do
      visit '/cads'
      click_on 'New CAD'
      expect(page).to have_content 'You are not authorized to access this page.'
    end

    specify 'I cannot create a new material' do
      visit '/materials'
      click_on 'New Material'
      expect(page).to have_content 'You are not authorized to access this page.'
    end

    specify 'I cannot create a new machine' do
      visit '/machines'
      click_on 'New Machine'
      expect(page).to have_content 'You are not authorized to access this page.'
    end
  end

  context 'As a Student' do
    let!(:user) { FactoryBot.create(:student_user) }
    specify 'I cannot add a new material' do
      visit '/materials'
      click_on 'New Material'
      expect(page).to have_content 'FT4'
    end
  end

  context 'As a Staff' do
    let!(:user) { FactoryBot.create(:staff_user) }

    specify 'I can read builds' do
      visit '/builds'
      expect(page).to have_content 'Listing Builds'
      expect(page).to have_content 'No Builds found'
    end

    specify 'I can read cads' do
      visit '/cads'
      expect(page).to have_content 'Listing Designs'
    end

    specify 'I can read materials' do
      visit '/materials'
      expect(page).to have_content 'Listing Materials'
    end

    specify 'I can read machines' do
      visit '/machines'
      expect(page).to have_content 'Listing Machines'
    end

    specify 'I can create a new build' do
      visit '/builds'
      click_on 'New Build'
      expect(page).to have_content 'Avg Modulus:'
    end

    specify 'I can create a new cad' do
      visit '/cads'
      click_on 'New CAD'
      expect(page).to have_content 'Part File'
    end

    specify 'I can create a new material' do
      visit '/materials'
      click_on 'New Material'
      expect(page).to have_content 'FT4'
    end

    specify 'I cannot create a new machine' do
      visit '/machines'
      click_on 'New Machine'
      expect(page).to have_content 'You are not authorized to access this page.'
    end
  end

  context 'As a Student' do
    let!(:user) { FactoryBot.create(:student_user) }

    specify 'I can read builds' do
      visit '/builds'
      expect(page).to have_content 'Listing Builds'
      expect(page).to have_content 'No Builds found'
    end

    specify 'I can read cads' do
      visit '/cads'
      expect(page).to have_content 'Listing Designs'
    end

    specify 'I can read materials' do
      visit '/materials'
      expect(page).to have_content 'Listing Materials'
    end

    specify 'I can read machines' do
      visit '/machines'
      expect(page).to have_content 'Listing Machines'
    end

    specify 'I can create a new build' do
      visit '/builds'
      click_on 'New Build'
      expect(page).to have_content 'Avg Modulus:'
    end

    specify 'I can create a new cad' do
      visit '/cads'
      click_on 'New CAD'
      expect(page).to have_content 'Part File'
    end

    specify 'I can create a new material' do
      visit '/materials'
      click_on 'New Material'
      expect(page).to have_content 'FT4'
    end

    specify 'I cannot create a new machine' do
      visit '/machines'
      click_on 'New Machine'
      expect(page).to have_content 'You are not authorized to access this page.'
    end
  end

  context 'As an admin' do
    let!(:user) { FactoryBot.create(:admin_user) }
    specify 'I can read builds' do
      visit '/builds'
      expect(page).to have_content 'Listing Builds'
    end

    specify 'I can read cads' do
      visit '/cads'
      expect(page).to have_content 'Listing Designs'
    end

    specify 'I can read materials' do
      visit '/materials'
      expect(page).to have_content 'Listing Materials'
    end

    specify 'I can read machines' do
      visit '/machines'
      expect(page).to have_content 'Listing Machines'
    end

    specify 'I can create a new build' do
      visit '/builds'
      click_on 'New Build'
      expect(page).to have_content 'Avg Modulus:'
    end

    specify 'I can create a new cad' do
      visit '/cads'
      click_on 'New CAD'
      expect(page).to have_content 'Part File'
    end

    specify 'I can create a new material' do
      visit '/materials'
      click_on 'New Material'
      expect(page).to have_content 'FT4'
    end

    specify 'I can create a new machine' do
      visit '/machines'
      click_on 'New Machine'
      expect(page).to have_content 'Back'
    end

    specify 'I can create a new group' do
      visit '/groups'
      click_on 'New Group'
      fill_in 'group_name', with: 'Some name'
      click_on 'Save'
      expect(page).to have_content 'Group was successfully created.'
    end

    specify 'I can update Builds' do
      visit '/builds'
      click_on 'Show'
      click_on 'Edit'
      check 'build_completed'
      click_on 'Update Build'
      expect(page).to have_content 'Build was successfully updated.'
    end

    specify 'I can update CADs' do
      visit '/cads'
      click_on 'Show'
      click_on 'Edit'
      check 'cad_archived'
      click_on 'Submit'
      expect(page).to have_content 'Cad was successfully updated.'
    end

    specify 'I can update Materials' do
      visit '/materials'
      click_on 'Show'
      click_on 'Edit'
      check 'material_archived'
      click_on 'Submit'
      expect(page).to have_content('Material cannot be updated since it is referenced.' || 'Material was successfully updated.')
    end

    specify 'I can update Materials' do
      visit '/materials'
      click_on 'Show'
      click_on 'Edit'
      check 'material_archived'
      click_on 'Submit'
      expect(page).to have_content('Material cannot be updated since it is referenced.' || 'Material was successfully updated.')
    end

    specify 'I can update Machines' do
      visit '/machines'
      click_on 'Show'
      click_on 'Edit'
      check 'machine_archived'
      click_on 'Submit'
      expect(page).to have_content('Machine cannot be edited as it is referenced by a build or cad.' || 'Machine was successfully updated.')
    end

    specify 'I can update groups' do
      visit '/groups'
      click_on 'Show'
      click_on 'Edit'
      click_on 'Update Group'
      expect(page).to have_content 'Group was successfully updated.'
    end

    specify 'I can update user roles' do
      visit '/users'
      click_on 'Update'
      expect(page).to have_content 'User was successfully updated.'
    end
  end
end
