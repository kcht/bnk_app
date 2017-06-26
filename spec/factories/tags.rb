FactoryGirl.define do
  factory :user do
    sequence(:id) {|n| n.to_s}

    initialize_with do
      new(
          id: id,
          name: 'Test',
          email: 'test@test.pl',
          password: 'test',
          password_confirmation: 'test'
      )
    end
  end
end
