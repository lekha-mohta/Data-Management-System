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
require 'rails_helper'

RSpec.describe BuildParameter, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
