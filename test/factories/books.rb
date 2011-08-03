# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :book do |f|
  f.isbn "MyString"
  f.ean "MyString"
  f.title "MyString"
  f.authors "MyText"
  f.edition "MyString"
  f.cover "MyString"
  f.publisher "MyString"
  f.pages 1
  f.publication_date "MyString"
  f.asin "MyString"
  f.description "MyText"
end