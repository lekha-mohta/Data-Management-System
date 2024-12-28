# == Schema Information
#
# Table name: group_users
#
#  id         :bigint           not null, primary key
#  groupId    :integer
#  userId     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (groupId => groups.id)
#  fk_rails_...  (userId => users.id)
#
require 'rails_helper'

RSpec.describe GroupUser, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
