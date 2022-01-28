class TweetJob < ApplicationJob
  queue_as :default

  def perform(tweet)
    # if already published, do nothing
    return if tweet.published?
    
    # rescheduled tweet to the future
    return if tweet.publish_at > Time.current

    tweet.publish_to_twitter
  end
end

# 11 AM to 8 AM change
# 8 AM job -> runs, publishes, sets tweet id
# 11 AM job -> runs, does nothing

# 2 PM to 5 PM change
# 2 PM job -> runs, does nothing
# 5 PM job -> runs, publishes, sets tweet id
