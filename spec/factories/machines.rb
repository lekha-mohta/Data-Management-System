# == Schema Information
#
# Table name: machines
#
#  id          :bigint           not null, primary key
#  archived    :boolean
#  createdBy   :integer
#  description :string
#  modifiedBy  :integer
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (createdBy => users.id)
#  fk_rails_...  (modifiedBy => users.id)
#
FactoryBot.define do
  factory :machine do
    # user {FactoryBot.build(:user)}

    name { 'MyString' }
    description { 'MyString' }
    archived { false }
  end
end
