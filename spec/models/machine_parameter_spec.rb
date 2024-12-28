# == Schema Information
#
# Table name: machine_parameters
#
#  id          :bigint           not null, primary key
#  machineId   :integer
#  parameterId :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (machineId => machines.id)
#  fk_rails_...  (parameterId => parameters.id)
#
require 'rails_helper'

RSpec.describe MachineParameter, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
