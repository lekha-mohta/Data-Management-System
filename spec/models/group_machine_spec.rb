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
require 'rails_helper'

RSpec.describe GroupMachine, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
