FactoryGirl.define do
  factory :admin do
    first_name 'Speedy'
    last_name  'Gonzalves'
    email 'speedy@appyantra.com'
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
end