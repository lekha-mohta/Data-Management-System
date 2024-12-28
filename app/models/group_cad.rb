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
class GroupCad < ApplicationRecord
  validates :cadId, uniqueness: { scope: :groupId, message: 'CAD already exists in group' }
  belongs_to :group, foreign_key: 'groupId'
  belongs_to :cad, foreign_key: 'cadId'
end
