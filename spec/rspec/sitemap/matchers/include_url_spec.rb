require "spec_helper"

describe "include_url matcher" do
  include RSpec::Sitemap::Matchers

  context "on a File" do
    let(:sitemap) { fixture('basic') }
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

  context "on a String" do

    let(:sitemap) { fixture('basic').read }

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

end
