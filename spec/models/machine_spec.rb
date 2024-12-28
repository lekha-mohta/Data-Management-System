# == Schema Information
#
# Table name: machines
#
#  id          :bigint           not null, primary key
#  archived    :boolean
#  createdBy   :integer
#  description :string
#  modifiedBy  :integer
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (createdBy => users.id)
#  fk_rails_...  (modifiedBy => users.id)
#
require 'rails_helper'

RSpec.describe Machine, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
