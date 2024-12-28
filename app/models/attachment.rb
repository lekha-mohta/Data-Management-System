# == Schema Information
#
# Table name: attachments
#
#  id         :bigint           not null, primary key
#  createdBy  :integer
#  file       :binary
#  modifiedBy :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (createdBy => users.id)
#  fk_rails_...  (modifiedBy => users.id)
#
class Attachment < ApplicationRecord
  belongs_to :created_by, class_name: 'User', foreign_key: 'createdBy'
  belongs_to :modified_by, class_name: 'User', foreign_key: 'modifiedBy'
end
