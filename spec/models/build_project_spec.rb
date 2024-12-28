# == Schema Information
#
# Table name: build_projects
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe BuildProject, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
