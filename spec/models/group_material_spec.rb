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
require 'rails_helper'

RSpec.describe GroupMaterial, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
