# == Schema Information
#
# Table name: groups
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :group do
    name { 'MyString' }
    description { 'MyString' }
  end
end
