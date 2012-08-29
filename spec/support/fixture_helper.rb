module FixtureHelper
  def fixture(type)
    File.open(File.expand_path("../../support/fixtures/sitemaps/#{type}.xml", __FILE__))
  end
end
