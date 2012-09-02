require "spec_helper"

describe "include_url matcher" do
  include RSpec::Sitemap::Matchers
  
  describe "#matches?" do

    shared_examples_for "a matcher that accepts a File or a String" do
      it "passes" do
        sitemap.should include_url('http://www.example.com')
      end

      it "fails" do
        expect {
          sitemap.should include_url('http://www.not-an-example.com')
        }.to raise_error { |error|
          error.message.should match("to include a URL to http://www.not-an-example.com")
        }
      end
    end

    it_should_behave_like "a matcher that accepts a File or a String" do
      let(:sitemap) { fixture('basic') }
    end

    it_should_behave_like "a matcher that accepts a File or a String" do
      let(:sitemap) { fixture('basic').read }
    end
    
    context "on any IO object that has a :read method" do
      let(:sitemap) { mock('sitemap') }
      before do
        sitemap.stub(:read).and_return(fixture('basic').read)
      end
    
      it "should accept any IO that has a :read method on it" do
        sitemap.should include_url('http://www.example.com')
      end
    end
  end

  describe "#priority" do

    context "when it is missing" do
      let(:sitemap) { fixture('basic') }
      it "fails" do
        expect {
          sitemap.should include_url('http://www.example.com').priority('0.5')
        }.to raise_error { |error|
          error.message.should match('to include a URL to http://www.example.com with a priority of 0.5 but the priority was not set')
        }
      end
    end

    context "when it is set" do
      let(:sitemap) { fixture('with_valid_priority') }
      it "passes" do
        sitemap.should include_url('http://www.example.com').priority('0.5')
      end

      it "fails" do
        expect {
          sitemap.should include_url('http://www.example.com').priority('0.8')
        }.to raise_error { |error|
          error.message.should match('to include a URL to http://www.example.com with a priority of 0.8 but it was set to 0.5')
        }
      end
    end


  end

end
