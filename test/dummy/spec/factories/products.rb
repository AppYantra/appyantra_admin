# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    name "product1"
    product_type "books"
    description "Book product"
  end
end
