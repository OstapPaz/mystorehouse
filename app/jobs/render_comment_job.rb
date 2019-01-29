class RenderCommentJob < ApplicationJob
  queue_as :default

  def perform(comment)
    ActionCable.server.broadcast "product:#{comment['product_id']}:comments", foo: render_comment(comment)
  end

  def render_comment(comment)
    ApplicationController.render json: comment.as_json
  end
end
