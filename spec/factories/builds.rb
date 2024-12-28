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
FactoryBot.define do
  factory :build do
    # user {FactoryBot.build(:user)}
    material { FactoryBot.build(:material) }
    machine { FactoryBot.build(:machine) }
    build_project { FactoryBot.build(:build_project) }
    # materialId { 1 }
    # processId { 1 }
    # projectId { 1 }
    name { 'MyString' }
    comments { 'MyString' }
    # archived { false }
    avgUTS { 1.5 }
    avgModules { 1.5 }
    avgEaB { 1.5 }
    # createdBy { 1 }
    # modifiedBy { 1 }
  end
end
