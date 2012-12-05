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

shared_examples_for "an attribute matcher" do |attribute, expected, not_expected|

  context "when #{attribute} is set" do

    it "passes" do
      passing_sitemap.should include_url('http://www.example.com').send(attribute, expected)
    end

    it "passes when invoked with with_ syntax" do
      passing_sitemap.should include_url('http://www.example.com').send("with_#{attribute}", expected)
    end

    it "fails" do
      expect {
        passing_sitemap.should include_url('http://www.example.com').send(attribute, not_expected)
      }.to raise_error { |error|
        error.message.should include("to include a URL to http://www.example.com with a #{attribute} of #{not_expected} but it was set to #{expected}")
      }
    end
  end

  context "when #{attribute} is NOT set" do

    it "fails" do
      expect {
        failing_sitemap.should include_url('http://www.example.com').send(attribute, expected)
      }.to raise_error { |error|
        error.message.should include("to include a URL to http://www.example.com with a #{attribute} of #{expected} but the #{attribute} was not set")
      }
    end
  end

end