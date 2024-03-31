class NotificationJob < ApplicationJob
  def perform(creator, title)
    User.all.each do |user|
      next if user.email == creator

      ActionCable.server.broadcast("notification_channel_#{user.id}", { creator: creator, title: title })
    end
  end
end
