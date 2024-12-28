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
class MachineParameter < ApplicationRecord
  belongs_to :machine, foreign_key: 'machineId'
  belongs_to :parameter, foreign_key: 'parameterId'
end
