FactoryGirl.define do

  factory :admin do
    first_name 'Speedy'
    last_name  'Gonzalves'
    sequence(:email) { |n| "admin#{n}@example.com" }
    password 'admin123'
    password_confirmation 'admin123'
  end

  factory :user do
    first_name 'Stan'
    last_name  'Marsh'
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'admin123'
    password_confirmation 'admin123'
  end

  factory :link do
    name 'website_url'
    text 'Go to the Website'
    href 'http://www.appyantra.com'
    # rel
    # target
    # type
    title 'Website URL'
  end

  factory :text do
    name 'company_name'
    value 'AppYantra'
  end

  factory :admin_setting do
    name 'website_url'
    display_name 'Website URL'
  end

  factory :page do
    sequence(:title) { |n| "Page#{n}" }
    published true
    category 'static-page'
    content 'This is a test page.'
    association :created_by, factory: :admin
    association :last_updated_by, factory: :admin
    slug nil
  end
end