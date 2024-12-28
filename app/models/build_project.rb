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
class BuildProject < ApplicationRecord
  validates :name, uniqueness: true, presence: true, length: { maximum: 50 }
end
