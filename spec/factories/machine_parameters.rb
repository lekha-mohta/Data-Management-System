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
FactoryBot.define do
  factory :machine_parameter do
    machine { FactoryBot.build(:machine) }
    parameter { FactoryBot.build(:parameter) }

    # machineId { 1 }
    # parameterId { 1 }
  end
end
