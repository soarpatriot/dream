FactoryGirl.define do
  factory :user do
    sequence(:mobile_number) {|i| "18601111#{i}"}
    password "12345678"
    sequence(:name) {|i| "d-#{i}"}

  end

  factory :owner, class: User do

    sequence(:mobile_number) {|i| "18601111#{i}"}
    password "12345678"
    sequence(:name) {|i| "d-#{i}"}

  end
end
