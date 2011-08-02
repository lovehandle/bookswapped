require 'spec_helper'

describe "books/show.html.haml" do
  before(:each) do
    @book = assign(:book, stub_model(Book,
      :isbn => "Isbn",
      :ean => "Ean",
      :title => "Title",
      :authors => "MyText",
      :edition => "Edition",
      :cover => "Cover",
      :publisher => "Publisher",
      :pages => 1,
      :publication_date => "Publication Date",
      :asin => "Asin",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Isbn/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Ean/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Edition/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Cover/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Publisher/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Publication Date/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Asin/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
