class TestCluster
  attr_reader :searchables

  def initialize
    @searchables = ActiveRecord::Base.descendants.select do |klass|
      klass.respond_to? :__elasticsearch__
    end
  end

  def setup_test
    allow_elastic_http
  end

  def teardown_test
    disable_elastic_http
    delete_indices
  end

private
  def allow_elastic_http
    WebMock.disable!
    WebMock.disable_net_connect!(allow_localhost: true, allow: 'elasticsearch')
  end

  def disable_elastic_http
    WebMock.disable!
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  def delete_indices
    searchables.each do |klass|
      opts = { index: klass.index_name }
      klass.__elasticsearch__.client.indices.delete opts
    end
  end
end

RSpec.configure do |config|
  test_cluster = TestCluster.new

  config.before :each, elasticsearch: true do
    test_cluster.setup_test
  end

  config.after :each, elasticsearch: true do
    test_cluster.teardown_test
  end
end
