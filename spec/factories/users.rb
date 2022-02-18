FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname              {Faker::Name.name}
    email                 {Faker::Internet.free_email}
    password              {Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1)}
    password_confirmation {password}
    first_name            {person.first.kanji}
    first_name_kana       {person.first.katakana}
    last_name             {person.last.kanji}
    last_name_kana        {person.last.katakana}
    birthday              {Faker::Date.between(from: 100.years.ago, to: Date.today)}
  end
end
