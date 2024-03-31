FactoryBot.define do
  factory :video do
    title { "My Video" }
    video_id { "video1" }
    description { "This is a video" }
    association :user, strategy: :build
  end
end
