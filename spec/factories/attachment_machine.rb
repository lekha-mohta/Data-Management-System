# == Schema Information
#
# Table name: attachment_processes
#
#  id           :bigint           not null, primary key
#  attachmentId :integer
#  processId    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryBot.define do
  factory :attachment_machine do
    attachmentId { 1 }
    machineId { 1 }
  end
end
