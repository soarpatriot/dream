FactoryGirl.define do
  factory :user do

    password "12345678"
    sequence(:name) {|i| "d-#{i}"}

  end

  factory :owner, class: User do

    password "12345678"
    sequence(:name) {|i| "d-#{i}"}

  end
end
