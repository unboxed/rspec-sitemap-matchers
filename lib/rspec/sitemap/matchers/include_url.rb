module RSpec::Sitemap::Matchers
  class IncludeUrl

    ALLOWED_ATTRS = %w(priority changefreq lastmod)

    def initialize(expected_location)
      @expected_location = expected_location
    end

    # @api private
    def matches?(actual)
      @actual = Nokogiri::XML(actual) { |config| config.noblanks }
      @nodes = @actual.xpath(construct_xpath)
      @nodes.any? && attributes_match?
    end

    def failure_message
      [].tap do |messages|
        messages << "expected #{@actual} to include a URL to #{@expected_location}"
        unmatched_attributes.each { |attribute, actual_value|
          if actual_value.nil?
            messages << "with a #{attribute} of #{expected_attributes[attribute]} but the #{attribute} was not set"
          else
            messages << "with a #{attribute} of #{expected_attributes[attribute]} but it was set to #{actual_value}"
          end
        }
      end.join(' ')
    end

    def priority(expected_priority)
      expected_attributes.merge!(:priority => expected_priority)
      self
    end

    def lastmod(expected_lastmod)
      expected_attributes.merge!(:lastmod => expected_lastmod)
      self
    end

    def changefreq(expected_changefreq)
      expected_attributes.merge!(:changefreq => expected_changefreq)
      self
    end

    ALLOWED_ATTRS.each do |attr|
      alias_method "with_#{attr}".to_sym, attr.to_sym
    end

    private

    def expected_attributes
      @expected_attributes ||= {}
    end

    def attributes_match?
      expected_attributes.all? do |key, value|
        matched_node.xpath(".//xmlns:#{key}[text()='#{value}']").any?
      end
    end

    def matched_attributes
      attributes = {}
      unless matched_node.nil?
        matched_node.children.each { |node| attributes[node.name.to_sym] = node.text }
      end
      attributes
    end

    def unmatched_attributes
      # First of all we remove all the attributes that match the expected values
      remaining_unmatched = expected_attributes.clone.delete_if do |key, expected_value|
        matched_attributes[key] == expected_value
      end
      # Then setting the remaining unmatched attributes to match the actual values found
      remaining_unmatched.each do |key, value|
        remaining_unmatched[key] = matched_attributes[key]
      end
      remaining_unmatched
    end

    def matched_node
      # Using the first node matched to a specified URL as it would not
      # make sense to have ultiple URL nodes with the same location.
      @nodes.first
    end

    def construct_xpath
      "//xmlns:url/xmlns:loc[text()='#{@expected_location}']/.."
    end

  end

  def include_url(url)
    IncludeUrl.new(url)
  end
end
