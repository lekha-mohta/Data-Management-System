# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  account_type       :string
#  current_sign_in_at :datetime
#  current_sign_in_ip :string
#  dn                 :string
#  email              :string           default(""), not null
#  givenname          :string
#  last_sign_in_at    :datetime
#  last_sign_in_ip    :string
#  mail               :string
#  ou                 :string
#  role               :integer          default("user")
#  sign_in_count      :integer          default(0), not null
#  sn                 :string
#  uid                :string
#  username           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email)
#  index_users_on_username  (username)
#
class User < ApplicationRecord
  include EpiCas::DeviseHelper

  has_many :user_groups, class_name: 'GroupUser', foreign_key: 'userId'
  has_many :groups, through: :user_groups

  enum role: { user: 0, student: 1, staff: 2, admin: 3 }

  def get_role_number
    # given the enum, return the integer value of the role
    if role == 'user'
      0
    elsif role == 'student'
      1
    elsif role == 'staff'
      2
    elsif role == 'admin'
      3
    end
  end

  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
end
