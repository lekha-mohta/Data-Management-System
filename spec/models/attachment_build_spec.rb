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
require 'rails_helper'

RSpec.describe AttachmentBuild, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
