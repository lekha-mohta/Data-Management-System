# == Schema Information
#
# Table name: cads
#
#  id         :bigint           not null, primary key
#  archived   :boolean
#  createdBy  :integer
#  file       :binary
#  file_type  :string
#  machineId  :integer
#  modifiedBy :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (createdBy => users.id)
#  fk_rails_...  (machineId => machines.id)
#  fk_rails_...  (modifiedBy => users.id)
#

class Cad < ApplicationRecord
  belongs_to :created_by, class_name: 'User', foreign_key: 'createdBy'
  belongs_to :modified_by, class_name: 'User', foreign_key: 'modifiedBy'
  belongs_to :machine, foreign_key: :machineId

  has_many :group_cads, foreign_key: 'cadId'

  validates :file, :file_type, presence: true
  validates :name, uniqueness: true, presence: true, length: { maximum: 50 }
  validates :machineId, presence: true, length: { maximum: 50 }
end
