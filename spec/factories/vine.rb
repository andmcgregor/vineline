require 'faker'

FactoryGirl.define do
  factory :vine_one, class: Vine do |f|
    f.post_id 363530372350361601
    f.url "https://vine.co/v/hqY0K1X9q7Z"
    f.description ""
    f.filmed DateTime.now
    f.created_at DateTime.now
    f.updated_at DateTime.now
    f.video_url "https://mtc.cdn.vine.co/r/videos/9150D85F-00E7-4B6C-ABFF-C776439185F0-528-00000081711B15E9_1a9536759ff.1.3.mp4"
    f.thumbnail "https://v.cdn.vine.co/r/thumbs/9150D85F-00E7-4B6C-ABFF-C776439185F0-528-00000081711B15E9_11bb5eea0a7.1.3.mp4.jpg"
  end

  factory :vine_two, class: Vine do |f|
    f.post_id 358706512690020353
    f.url "https://vine.co/v/hmLTTaqaEw6"
    f.description ""
    f.filmed DateTime.now - 5
    f.created_at DateTime.now
    f.updated_at DateTime.now
    f.video_url "https://mtc.cdn.vine.co/r/videos/2BF457E3-DD28-407E-A6C3-4BF2616279C3-412-0000008C903EF68B_1be8fb326ff.1.3.mp4"
    f.thumbnail "https://v.cdn.vine.co/r/thumbs/2BF457E3-DD28-407E-A6C3-4BF2616279C3-412-0000008C903EF68B_15305695794.1.3.mp4.jpg"
  end
end
