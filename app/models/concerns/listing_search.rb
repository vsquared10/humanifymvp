module ListingSearch
  extend ActiveSupport::Concern

  include do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    include Indexing
    after_touch () { __elasticsearch__.index_document }
  end

  module Indexing
    #self.as_json()
  end
end
