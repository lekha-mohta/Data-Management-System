# == Schema Information
#
# Table name: parameters
#
#  id         :bigint           not null, primary key
#  name       :string
#  unit       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :parameter do
    name { 'MyString' }
    unit { 'MyString' }
  end
end
