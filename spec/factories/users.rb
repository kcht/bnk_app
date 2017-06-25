FactoryGirl.define do
  factory :user do
    sequence(:id) { |n| n.to_s }
  end

  initialize_with do
    new(
        id: id,
        name: 'Test',
        email: 'test@test.pl',
        password: 'test',
        password_confirmation: 'test'
    )
  end

  trait :without_remember_digest do
    remember_digest nil
  end
end
