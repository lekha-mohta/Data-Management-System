# == Schema Information
#
# Table name: build_parameters
#
#  id          :bigint           not null, primary key
#  buildId     :integer
#  machineId   :integer
#  parameterId :integer
#  value       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (buildId => builds.id)
#  fk_rails_...  (machineId => machines.id)
#  fk_rails_...  (parameterId => parameters.id)
#
FactoryBot.define do
  factory :build_parameter do
    build { FactoryBot.build(:build) }
    parameter { FactoryBot.build(:parameter) }
    buildId { 1 }
    processId { 1 }
    parameterId { 1 }
    value { 'MyString' }
  end
end
