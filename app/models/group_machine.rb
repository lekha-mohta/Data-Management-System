# == Schema Information
#
# Table name: group_machines
#
#  id         :bigint           not null, primary key
#  groupId    :integer
#  machineId  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (groupId => groups.id)
#  fk_rails_...  (machineId => machines.id)
#
class GroupMachine < ApplicationRecord
  validates :machineId, uniqueness: { scope: :groupId, message: 'Machine already exists in group' }
  belongs_to :group, foreign_key: 'groupId'
  belongs_to :machine, foreign_key: 'machineId'
end
