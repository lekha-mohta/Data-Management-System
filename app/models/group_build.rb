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
class GroupBuild < ApplicationRecord
  validates :buildId, uniqueness: { scope: :groupId, message: 'Build already exists in group' }
  belongs_to :group, foreign_key: 'groupId'
  belongs_to :build, foreign_key: 'buildId'
end
