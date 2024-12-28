# == Schema Information
#
# Table name: group_builds
#
#  id         :bigint           not null, primary key
#  buildId    :integer
#  groupId    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (buildId => builds.id)
#  fk_rails_...  (groupId => groups.id)
#
FactoryBot.define do
  factory :group_build do
    # user {FactoryBot.build(:user)}
    group { FactoryBot.build(:group) }
    build { FactoryBot.build(:build) }
    # groupId { 1 }
    # buildId { 1 }
  end
end
