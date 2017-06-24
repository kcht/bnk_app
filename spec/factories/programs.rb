FactoryGirl.define do
  factory :program do
    sequence(:id) {|n| n.to_s}

    initialize_with do
      new(
          id: id,
          number: id,
          name: 'example',
          description: 'description'
      )
    end
  end
end

