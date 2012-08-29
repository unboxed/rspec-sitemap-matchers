require "spec_helper"

describe "include_url matcher" do
  include RSpec::Sitemap::Matchers

  context "on a File" do
    subject { fixture('basic') }
    it "passes" do
      subject.should include_url('http://www.example.com')
    end

    it "fails" do
      expect {
        subject.should include_url('http://www.not-an-example.com')
      }.to raise_error {|e|
        e.message.should match("to include a URL to http://www.not-an-example.com")
      }
    end

  end

  context "on a String" do

    subject { fixture('basic').read }

    it "passes" do
      subject.should include_url('http://www.example.com')
    end

    it "fails" do
      expect {
        subject.should include_url('http://www.not-an-example.com')
      }.to raise_error {|e|
        e.message.should match("to include a URL to http://www.not-an-example.com")
      }
    end

  end

end
