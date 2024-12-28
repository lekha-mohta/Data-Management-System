# == Schema Information
#
# Table name: group_cads
#
#  id         :bigint           not null, primary key
#  cadId      :integer
#  groupId    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (cadId => cads.id)
#  fk_rails_...  (groupId => groups.id)
#
FactoryBot.define do
  factory :group_cad do
    # user {FactoryBot.build(:user)}
    group { FactoryBot.build(:group) }
    cad { FactoryBot.build(:cad) }
  end
end
