# == Schema Information
#
# Table name: builds
#
#  id               :bigint           not null, primary key
#  avgEaB           :float
#  avgModules       :float
#  avgUTS           :float
#  comments         :string
#  completed        :boolean
#  createdBy        :integer
#  machineId        :integer
#  materialId       :integer
#  modifiedBy       :integer
#  name             :string
#  projectId        :integer
#  tensile_raw_data :binary
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (createdBy => users.id)
#  fk_rails_...  (machineId => machines.id)
#  fk_rails_...  (materialId => materials.id)
#  fk_rails_...  (modifiedBy => users.id)
#  fk_rails_...  (projectId => build_projects.id)
#
require 'rails_helper'

RSpec.describe Build, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
