FactoryBot.define do

  factory :profile do
    first_name              {Faker::Name.first_name}
    last_name               {Faker::Name.last_name}
    first_name_kana         {Faker::Games::Pokemon.name}
    last_name_kana          {Faker::Games::Pokemon.name}
    birth_date              {Faker::Date.between(from: '1990-01-01', to: '2014-09-25')}
    user
  end

end