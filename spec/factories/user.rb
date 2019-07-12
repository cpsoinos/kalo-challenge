FactoryBot.define do

  factory :user do
    email { Faker::Internet.email }
    name  { Faker::FunnyName.name }
    global_admin { false }
    timezone { 'EST' }
    receive_marketing { false }
    external_id { Faker::Alphanumeric.alphanumeric(10) }
    skills { [Faker::Verb.ing_form, Faker::Verb.ing_form].uniq }
  end

end
