FactoryBot.define do
  factory :user do
    sequence(:id) {|n| n.to_s}

    initialize_with do
      new(
          id: id,
          name: 'Test',
          email: 'test@test.pl',
          password: 'test',
          password_confirmation: 'test',
          admin: false
      )
    end
  end

  trait :without_remember_digest do
    remember_digest nil
  end

  trait :admin do
    admin true
  end

  trait :not_admin do
    admin false
  end
end
