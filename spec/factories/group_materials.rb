# == Schema Information
#
# Table name: group_materials
#
#  id         :bigint           not null, primary key
#  groupId    :integer
#  materialId :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (groupId => groups.id)
#  fk_rails_...  (materialId => materials.id)
#
FactoryBot.define do
  factory :group_material do
    group { FactoryBot.build(:group) }
    material { FactoryBot.build(:material) }
    # groupId { 1 }
    # materialId { 1 }
  end
end
