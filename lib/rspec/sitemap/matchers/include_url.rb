module RSpec::Sitemap::Matchers
  class IncludeUrl
    def initialize(expected)
      @expected = expected
    end

    # @api private
    def matches?(actual)
      @actual = actual
      xpath = construct_xpath
      Nokogiri::XML(@actual).xpath(xpath).any?
    end

    def failure_message
      "expected #{@actual} to include a URL to #{@expected}"
    end

  private

    def construct_xpath
      "//xmlns:url/xmlns:loc[. = '#{@expected}']"
    end

  end

  def include_url(url)
    IncludeUrl.new(url)
  end
end
