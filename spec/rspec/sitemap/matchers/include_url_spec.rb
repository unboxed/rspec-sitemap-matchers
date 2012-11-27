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

    describe "#priority" do

      it_should_behave_like "an attribute matcher", "priority", 0.5, 0.8 do
        let(:passing_sitemap) { fixture('with_valid_priority') }
        let(:failing_sitemap) { fixture('basic') }
      end

    end

    describe "#changefreq" do

      it_should_behave_like "an attribute matcher", "changefreq", "weekly", "daily" do
        let(:passing_sitemap) { fixture('with_valid_priority') }
        let(:failing_sitemap) { fixture('basic') }
      end

    end

    describe "#lastmod" do

      it_should_behave_like "an attribute matcher", "lastmod", "2012-11-27T16:40:53+01:00", "not prova" do
        let(:passing_sitemap) { fixture('with_valid_priority') }
        let(:failing_sitemap) { fixture('basic') }
      end

    end
  end
end
