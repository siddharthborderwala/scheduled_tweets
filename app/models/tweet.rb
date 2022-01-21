class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :twitter_account

  validates :body, length: { minimum: 1, maximum: 280 }
  validates :publish_at, presence: true

  after_initialize do
    self.publish_at ||= 1.hours.from_now
  end

  def published?
    tweet_id?
  end

  def published_to_twitter
    tweet = twitter_account.client.update(body)
    update(tweet_id: tweet.id)
  end
end
