FactoryBot.define do

  factory :sending_destination do
    destination_first_name           {Faker::Name.first_name}
    destination_last_name            {Faker::Name.last_name}
    destination_first_name_kana      {Faker::Games::Pokemon.name}
    destination_last_name_kana       {Faker::Games::Pokemon.name}
    prefecture                       {"北海道"}
    city                             {Faker::Address.city}
    house_number                     {Faker::Address.street_address}
    post_code                        {Faker::Number.number(digits: 7)}
    phone_number                     {Faker::Number.number(digits: 10)}
    user
  end

end