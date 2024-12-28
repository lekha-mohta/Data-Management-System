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
class Machine < ApplicationRecord
  belongs_to :created_by, class_name: 'User', foreign_key: 'createdBy'
  belongs_to :modified_by, class_name: 'User', foreign_key: 'modifiedBy'

  has_many :machine_parameters, foreign_key: 'machineId'
  has_many :parameters, through: :machine_parameters
  has_many :builds, foreign_key: 'buildId'
  has_many :cads, foreign_key: 'machineId'
  has_many :group_machines, foreign_key: 'machineId'

  validates :name, uniqueness: true, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 50 }
end
