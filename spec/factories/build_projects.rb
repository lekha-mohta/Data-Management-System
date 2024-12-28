# == Schema Information
#
# Table name: build_projects
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :build_project do
    name { 'MyString' }
    description { 'MyString' }
  end
end
