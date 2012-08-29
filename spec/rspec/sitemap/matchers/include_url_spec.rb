require "spec_helper"

describe "include_url matcher" do
  include RSpec::Sitemap::Matchers

  shared_examples_for "a matcher that accepts a File or a String" do
    it "passes" do
      sitemap.should include_url('http://www.example.com')
    end

    it "fails" do
      expect {
        sitemap.should include_url('http://www.not-an-example.com')
      }.to raise_error {|e|
        e.message.should match("to include a URL to http://www.not-an-example.com")
      }
    end
  end

  it_should_behave_like "a matcher that accepts a File or a String" do
    let(:sitemap) { fixture('basic') }
  end

  it_should_behave_like "a matcher that accepts a File or a String" do
    let(:sitemap) { fixture('basic').read }
  end

end
