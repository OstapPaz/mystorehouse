class CommentsChannel < ApplicationCable::Channel
  def follow(params)
    stop_all_streams
    stream_from "product:#{params['product_id'].to_i}:comments"
  end

  def unfollow
    stop_all_streams
  end
end