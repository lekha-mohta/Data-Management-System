# == Schema Information
#
# Table name: cads
#
#  id         :bigint           not null, primary key
#  archived   :boolean
#  createdBy  :integer
#  file       :binary
#  file_type  :string
#  machineId  :integer
#  modifiedBy :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (createdBy => users.id)
#  fk_rails_...  (machineId => machines.id)
#  fk_rails_...  (modifiedBy => users.id)
#
FactoryBot.define do
  factory :cad do
    user { FactoryBot.build(:user) }
    machine { FactoryBot.build(:machine) }
    name { 'MyString' }
    type { '' }
    archived { false }
    file { '' }
    # createdBy { 1 }
    # modifiedBy { 1 }
  end
end
