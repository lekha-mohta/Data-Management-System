# == Schema Information
#
# Table name: parameters
#
#  id         :bigint           not null, primary key
#  name       :string
#  unit       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Parameter, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
