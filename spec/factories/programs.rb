FactoryGirl.define do
  factory :program do
    sequence(:id) { |n| n.to_s }
  end
end

