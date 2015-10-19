require 'rails_helper'

describe Offer do
  describe 'associations' do
    it { should belong_to :listing }
    it { should belong_to :user }
  end

  describe 'validations' do
    let(:listing) { create(:listing) }
    let(:offer) { create(:offer, listing_id: listing.id) }

    pending 'create offer and listing factories' do
      should validate_inclusion_of(:status).in_array ["pending", "accepted", "declined"]
    end
  end
end
