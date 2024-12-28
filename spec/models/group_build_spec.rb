# == Schema Information
#
# Table name: group_builds
#
#  id         :bigint           not null, primary key
#  buildId    :integer
#  groupId    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (buildId => builds.id)
#  fk_rails_...  (groupId => groups.id)
#
require 'rails_helper'

RSpec.describe GroupBuild, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
