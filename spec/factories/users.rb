FactoryBot.define do
  factory :user do
    name { "Example User" }
    email { "test@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end