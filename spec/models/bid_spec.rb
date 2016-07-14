describe Bid do
  before do
    # maybe not the best way to stub external notif service
    allow(Pusher).to receive(:trigger)
  end

  it 'inherits from Offer' do
    expect(described_class).to be < Offer
  end

  describe 'validations' do
    let(:valid_listing) { build(:listing, type: 'ListingOffer', points: 10) }
    subject { build(:bid, listing: valid_listing) }

    it { should validate_numericality_of(:points).is_greater_than(0) }

    context 'with a non-offer listing type' do
      let(:ask_listing) { build(:listing, type: 'ListingAsk', points: 10) }
      let(:bid) { build(:bid, points: 20, listing: valid_listing) }

      it 'is invalid' do
        expect(bid).to be_valid # sanity check
        bid.listing = ask_listing
        expect(bid).to_not be_valid
      end
    end

    context 'points on bid is lower than listing amount' do
      let(:invalid_listing) { build(:listing, type: 'ListingOffer', points: 10) }
      let(:bid) { build(:bid, points: 20, listing: valid_listing) }

      it 'is invalid' do
        expect(bid).to be_valid
        bid.points = bid.listing.points - 5
        expect(bid).to_not be_valid
      end
    end

    context "points are higher than the listing's highest offer points" do
      let(:listing_with_cap) { create(:listing, type: 'ListingOffer', with_highest_offer: true) }
      let(:valid_listing) { build(:listing, type: 'ListingOffer', points: 10) }
      let(:bid) { build(:bid, points: 20, listing: valid_listing) }


      it 'is invalid' do
        expect(bid).to be_valid
        listing_with_cap.offers.push bid
        expect(bid).to_not be_valid
      end

      context 'listing has no highest offer cap' do
        it 'is valid' do
          expect(bid).to be_valid
        end
      end
    end

    context 'user has less points than bid' do
      let(:user) { create(:user) } # inits to 250
      let(:valid_listing) { create(:listing, type: 'ListingOffer', points: 10) }
      let(:bid) { build(:bid, user: user, listing: valid_listing, points: 20) }

      it 'is invalid' do
        expect(bid).to be_valid
        bid.user.subtract_points(90)
        bid.save
        expect(bid).to_not be_valid
      end
    end
  end
end
