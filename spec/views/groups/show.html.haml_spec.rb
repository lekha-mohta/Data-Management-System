require 'rails_helper'

RSpec.describe 'groups/show', type: :view do
  before(:each) do
    @group = assign(:group, Group.create!(
                              name: 'Group1',
                              description: 'Description of Group 1'
                            ))
    @users = assign(:users,
                    User.all)
    @builds = assign(:builds,
                     Build.all)
    @cads = assign(:cads, Cad.all)
    @machines = assign(:machines, Machine.all)
    @materials = assign(:materials, Material.all)
  end

  #   it "renders the group info" do
  #     render
  #   end

  it 'renders the group details' do
    render
    expect(rendered).to match(/Group details/)
    expect(rendered).to match(/#{@group.name}/)
    expect(rendered).to match(/#{@group.description}/)
  end

  it 'renders the group objects' do
    render
    expect(rendered).to match(/Group Objects/)
  end

  it 'renders the users' do
    render
    @users.each do |user|
      expect(rendered).to match(/#{user.email}/)
    end
  end

  it 'renders the builds' do
    render
    @builds.each do |build|
      expect(rendered).to match(/#{build.name}/)
    end
  end

  it 'renders the cads' do
    render
    @cads.each do |cads|
      expect(rendered).to match(/#{cads.name}/)
    end
  end

  it 'renders the machines' do
    render
    expect(rendered).to match(/P100 \(LS\)/)
    expect(rendered).to match(/VX200 \(HSS\)/)
  end

  it 'renders the materials' do
    render
    @materials.each do |material|
      expect(rendered).to match(/#{material.name}/)
    end
  end
end
