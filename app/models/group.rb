# == Schema Information
#
# Table name: groups
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Group < ApplicationRecord
  has_many :group_users, class_name: 'GroupUser', foreign_key: 'groupId'
  has_many :users, through: :group_users, source: :user

  has_many :group_materials, foreign_key: 'groupId'
  has_many :materials, through: :group_materials, source: :material
  accepts_nested_attributes_for :group_materials

  has_many :group_cads, foreign_key: 'groupId'
  has_many :cads, through: :group_cads, source: :cad

  has_many :group_builds, foreign_key: 'groupId'
  has_many :builds, through: :group_builds, source: :build

  has_many :group_machines, foreign_key: 'groupId'
  has_many :machines, through: :group_machines, source: :machine

  validates :name, uniqueness: { scope: :id }, presence: true, length: { maximum: 50 }

  def get_group_users
    users
  end

  def get_group_materials
    materials
  end

  def get_group_cads
    cads
  end

  def get_group_builds
    builds
  end

  def get_group_machines
    machines
  end
end
