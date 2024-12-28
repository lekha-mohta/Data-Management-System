# == Schema Information
#
# Table name: builds
#
#  id               :bigint           not null, primary key
#  avgEaB           :float
#  avgModules       :float
#  avgUTS           :float
#  comments         :string
#  completed        :boolean
#  createdBy        :integer
#  machineId        :integer
#  materialId       :integer
#  modifiedBy       :integer
#  name             :string
#  projectId        :integer
#  tensile_raw_data :binary
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (createdBy => users.id)
#  fk_rails_...  (machineId => machines.id)
#  fk_rails_...  (materialId => materials.id)
#  fk_rails_...  (modifiedBy => users.id)
#  fk_rails_...  (projectId => build_projects.id)
#
class Build < ApplicationRecord
  validates :materialId, :machineId, :projectId, presence: true

  validates :name, uniqueness: true, presence: true, length: { maximum: 50 }
  validates :avgEaB, :avgModules, :avgUTS, numericality: true

  belongs_to :created_by, class_name: 'User', foreign_key: 'createdBy'
  belongs_to :modified_by, class_name: 'User', foreign_key: 'modifiedBy'

  belongs_to :material, foreign_key: 'materialId'
  belongs_to :machine, foreign_key: 'machineId'
  belongs_to :build_project, foreign_key: 'projectId'

  has_many :build_parameters, foreign_key: 'buildId'

  accepts_nested_attributes_for :build_parameters

  has_many :group_builds, foreign_key: 'buildId'
  has_many :groups, through: :group_builds

  def self.ransackable_attributes(_auth_object = nil)
    %w[avgEaB avgModules avgUTS comments createdBy created_at id machineId materialId modifiedBy name projectId
       updated_at]
  end
end
