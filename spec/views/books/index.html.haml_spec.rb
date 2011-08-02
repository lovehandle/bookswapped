require 'spec_helper'

describe "books/index.html.haml" do
  before(:each) do
    assign(:books, [
      stub_model(Book,
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
      ),
      stub_model(Book,
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
      )
    ])
  end

  it "renders a list of books" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Isbn".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ean".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Edition".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Cover".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Publisher".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Publication Date".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Asin".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
