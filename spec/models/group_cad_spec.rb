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
require 'rails_helper'

RSpec.describe GroupCad, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
