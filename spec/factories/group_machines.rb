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
FactoryBot.define do
  factory :group_machine do
    group { FactoryBot.build(:group) }
    machine { FactoryBot.build(:machine) }
    groupId { 1 }
    machineId { 1 }
  end
end
