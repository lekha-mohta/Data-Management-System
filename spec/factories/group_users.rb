# == Schema Information
#
# Table name: group_users
#
#  id         :bigint           not null, primary key
#  groupId    :integer
#  userId     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (groupId => groups.id)
#  fk_rails_...  (userId => users.id)
#
FactoryBot.define do
  factory :group_user do
    group { FactoryBot.build(:group) }
    user { FactoryBot.build(:user) }

    # groupId { 1 }
    # userId { 1 }
  end
end
