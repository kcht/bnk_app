FactoryBot.define do
  factory :program_tag do
    sequence(:id) {|n| n.to_s}

    initialize_with do
      new(
          id: id
      )
    end
  end
end
