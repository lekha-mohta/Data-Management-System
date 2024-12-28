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
class GroupUser < ApplicationRecord
  validates :userId, uniqueness: { scope: :groupId, message: 'User already exists in group' }
  belongs_to :group, foreign_key: 'groupId'
  belongs_to :user, foreign_key: 'userId'
end
