# == Schema Information
#
# Table name: attachment_builds
#
#  id           :bigint           not null, primary key
#  attachmentId :integer
#  buildId      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (attachmentId => attachments.id)
#  fk_rails_...  (buildId => builds.id)
#
FactoryBot.define do
  factory :attachment_build do
    attachmentId { 1 }
    buildId { 1 }
  end
end
