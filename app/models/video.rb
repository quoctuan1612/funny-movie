class Video < ApplicationRecord
  belongs_to :user

  validates :title, :video_id, presence: true
  validates :video_id, uniqueness: true

  after_create_commit :send_notification

  private

  def send_notification
    NotificationJob.perform_later(user.email, title)
  end
end
