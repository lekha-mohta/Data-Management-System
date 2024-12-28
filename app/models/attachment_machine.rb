# == Schema Information
#
# Table name: attachment_machines
#
#  id           :bigint           not null, primary key
#  attachmentId :integer
#  machineId    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (attachmentId => attachments.id)
#  fk_rails_...  (machineId => machines.id)
#
class AttachmentMachine < ApplicationRecord
end
