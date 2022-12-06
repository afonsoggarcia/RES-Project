class ForumBotJob < ApplicationJob
  queue_as :default

  def perform(message)
    bad_words = %w[fuck bullshit fucker ass dick bitch bastard whore kill beat shit nigga cunt cock faggot]
    words = message.split
    words.all? { |word| !bad_words.include?(word) }
  end
end
