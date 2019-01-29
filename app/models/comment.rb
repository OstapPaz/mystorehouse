class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product
  after_create_commit { RenderCommentJob.perform_now self }
end
