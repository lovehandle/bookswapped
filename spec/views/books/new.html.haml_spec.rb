require 'spec_helper'

describe "books/new.html.haml" do
  before(:each) do
    assign(:book, stub_model(Book,
      :isbn => "MyString",
      :ean => "MyString",
      :title => "MyString",
      :authors => "MyText",
      :edition => "MyString",
      :cover => "MyString",
      :publisher => "MyString",
      :pages => 1,
      :publication_date => "MyString",
      :asin => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new book form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => books_path, :method => "post" do
      assert_select "input#book_isbn", :name => "book[isbn]"
      assert_select "input#book_ean", :name => "book[ean]"
      assert_select "input#book_title", :name => "book[title]"
      assert_select "textarea#book_authors", :name => "book[authors]"
      assert_select "input#book_edition", :name => "book[edition]"
      assert_select "input#book_cover", :name => "book[cover]"
      assert_select "input#book_publisher", :name => "book[publisher]"
      assert_select "input#book_pages", :name => "book[pages]"
      assert_select "input#book_publication_date", :name => "book[publication_date]"
      assert_select "input#book_asin", :name => "book[asin]"
      assert_select "textarea#book_description", :name => "book[description]"
    end
  end
end
