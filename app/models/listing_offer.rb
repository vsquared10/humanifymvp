class ListingOffer < Listing
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  # prefix class with env so dev/test/prod don't ever clash accidentally
  index_name [Rails.env, self.name.downcase].join('_')

  validates_presence_of :points
  validates :duration,
    inclusion: {
      in: [1, 3, 5, 7, 10],
      message: 'Listing duration can only be 1,3,5,7,10 days.'
    },
    allow_nil: true
end
