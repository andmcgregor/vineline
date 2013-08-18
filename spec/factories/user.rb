FactoryGirl.define do
  factory :user do |f|
    f.username "example_user"
    f.full_name "Example User"
    f.avatar "1.jpg"
    f.uid "1"
    f.oauth_token "12345"
    f.oauth_secret "12345"
  end
end
