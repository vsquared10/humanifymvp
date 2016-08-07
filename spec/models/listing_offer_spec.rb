describe ListingOffer do
  subject { build(:listing_offer) }

  it 'is a listing' do
    expect(described_class).to be < Listing
  end

  describe 'searching', elasticsearch: true do
    let(:lorem) { Faker::Lorem.sentence }
    let(:lorem2) { Faker::Lorem.word }

    def import_and_refresh
      ListingOffer.import force: true
      ListingOffer.__elasticsearch__.refresh_index!
    end

    def first_search_result
      results = ListingOffer.search('*').results
      results.first
    end

    it 'indexes whole records on save' do
      subject.description = lorem
      subject.save
      import_and_refresh
      expect(first_search_result.description).to eq lorem

      subject.update_attributes description: lorem2
      import_and_refresh # including the callbacks doesn't index changes
      expect(first_search_result.description).to eq lorem2
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:points) }
    it { should allow_values(1, 3, 5, 7, 10, nil).for(:duration) }
    it do
      should_not(allow_values(4, 6, 8, 11)
                  .for(:duration)
                  .with_message("Listing duration can only be 1,3,5,7,10 days."))
    end
  end
end
