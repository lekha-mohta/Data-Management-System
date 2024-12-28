# == Schema Information
#
# Table name: materials
#
#  id                   :bigint           not null, primary key
#  CoSHH                :binary
#  DSC                  :binary
#  FT4                  :binary
#  MSDS                 :binary
#  archived             :boolean
#  createdBy            :integer
#  crystallisationOnset :float
#  description          :string
#  location             :string
#  material_type        :string
#  meltingOnset         :float
#  modifiedBy           :integer
#  name                 :string
#  quantity             :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (createdBy => users.id)
#  fk_rails_...  (modifiedBy => users.id)
#

class Material < ApplicationRecord
  belongs_to :created_by, class_name: 'User', foreign_key: 'createdBy'
  belongs_to :modified_by, class_name: 'User', foreign_key: 'modifiedBy'

  has_many :group_materials, foreign_key: 'materialId'
  has_many :groups, through: :group_materials

  validates :name, uniqueness: true, presence: true, length: { maximum: 50 }
  validates :quantity, numericality: true, presence: true
  validates :location, presence: true, length: { maximum: 50 }
end
