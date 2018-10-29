FactoryBot.define do
  factory :tag do
    sequence(:id) {|n| n.to_s}

    initialize_with do
      new(
          id: id,
          name: 'TEST NAME',
          description: 'test'
      )
    end
  end
end
