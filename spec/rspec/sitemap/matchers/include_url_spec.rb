require "spec_helper"

module RSpec::Sitemap::Matchers
  describe IncludeUrl do
    include RSpec::Sitemap::Matchers
  
    describe "#matches?" do

      shared_examples_for "a matcher that passes or fails" do
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

      context "on a File" do
        it_should_behave_like "a matcher that passes or fails" do
          let(:sitemap) { fixture('basic') }
        end
      end
      
      context "on a String" do
        it_should_behave_like "a matcher that passes or fails" do
          let(:sitemap) { fixture('basic').read }
        end
      end

      context "on any IO object that has a :read method" do
        before do
          sitemap.stub(:read).and_return(fixture('basic').read)
        end
        
        it_should_behave_like "a matcher that passes or fails" do
          let(:sitemap) { mock('sitemap') }
        end
      end
    end

    describe "#failure_message" do

      let(:sitemap) { fixture('basic').read }

      it "should not raise error when attributes are queried on missing url" do
        expect {
          # not included url
          sitemap.should include_url('http://www.example.org').priority(0.5)
        }.to_not raise_error NoMethodError
      end
    end

    describe "#priority" do
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

      context "when it is NOT set" do
        let(:sitemap) { fixture('basic') }
        it "fails" do
          expect {
            sitemap.should include_url('http://www.example.com').priority('0.5')
          }.to raise_error { |error|
            error.message.should match('to include a URL to http://www.example.com with a priority of 0.5 but the priority was not set')
          }
        end
      end
    end
  end
end
