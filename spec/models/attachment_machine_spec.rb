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
require 'rails_helper'

RSpec.describe AttachmentMachine, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
