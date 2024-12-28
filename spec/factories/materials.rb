# == Schema Information
#
# Table name: materials
#
#  id                   :bigint           not null, primary key
#  CoSHH                :binary
#  DSC                  :binary
#  FT4                  :binary
#  MSDS                 :binary
#  archived             :boolean
#  createdBy            :integer
#  crystallisationOnset :float
#  description          :string
#  location             :string
#  material_type        :string
#  meltingOnset         :float
#  modifiedBy           :integer
#  name                 :string
#  quantity             :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (createdBy => users.id)
#  fk_rails_...  (modifiedBy => users.id)
#
FactoryBot.define do
  factory :material do
    # user {FactoryBot.build(:user)}
    name { 'MyString' }
    description { 'MyString' }
    quantity { 1 }
    # type { "" }
    archived { false }
    meltingOnset { 1.5 }
    crystallisationOnset { 1.5 }
    MSDS { '' }
    CoSHH { '' }
    DSC { '' }
    FT4 { '' }
    # createdBy { "MyString" }
    # modifiedBy { "MyString" }
  end
end
