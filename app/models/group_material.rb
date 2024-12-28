# == Schema Information
#
# Table name: group_materials
#
#  id         :bigint           not null, primary key
#  groupId    :integer
#  materialId :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (groupId => groups.id)
#  fk_rails_...  (materialId => materials.id)
#
class GroupMaterial < ApplicationRecord
  validates :groupId, uniqueness: { scope: :materialId, message: 'Material already exists in group' }
  belongs_to :group, foreign_key: 'groupId'
  belongs_to :material, foreign_key: 'materialId'
end
