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
class Parameter < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :unit, presence: true
  has_many :machine_parameters, foreign_key: 'parameterId'
  has_many :machines, through: :machine_parameters
end
