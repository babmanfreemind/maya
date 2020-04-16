FactoryBot.define do
  factory :user do
    # sequence(:id) { |n| n }
    email { "wizard@wizard.com" }
    password { "azerty123" }
  end
end