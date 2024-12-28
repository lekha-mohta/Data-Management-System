# == Schema Information
#
# Table name: attachments
#
#  id         :bigint           not null, primary key
#  createdBy  :integer
#  file       :binary
#  modifiedBy :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (createdBy => users.id)
#  fk_rails_...  (modifiedBy => users.id)
#
FactoryBot.define do
  factory :attachment do
    user { FactoryBot.build(:user) }
    name { 'MyString' }
    file { '' }
  end
end
