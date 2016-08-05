describe Offer do
  subject { build(:offer) }

  before do
    allow(Pusher).to receive(:trigger) #dup1
  end

  describe 'associations' do
    it { should belong_to :listing }
    it { should belong_to :user }
  end

  describe 'validations' do
    before do
      expect(subject).to be_valid
    end

    it { should validate_inclusion_of(:status).in_array(['pending', 'accepted', 'declined']) }

    context 'belongs to an expired ListingOffer' do
      it 'is invalid' do
        subject.listing.duration = 1 # converted to days
        subject.listing.created_at = 5.days.ago
        subject.listing.save
        expect(subject).to_not be_valid
      end
    end

    context 'user creates both listing and offer' do
      it 'is invalid' do
        subject.user = subject.listing.user
        expect(subject).to_not be_valid
      end
    end
  end

  describe 'creating an offer' do
    it "notifies the listing's user" do
      expect{
        subject.save
      }.to change(Notification, :count).by(1)
    end
  end

  describe '#accept' do
    before { subject.save }

    context 'offer has points' do
      it 'starts an exchange between the offer user and listing user' do
        expect{
          subject.accept
        }.to change(Exchange, :count).by(1)
      end

      context 'exchange is paid' do
        before { subject.accept }

        it 'updates the offer status to accepted' do
          expect(subject.status).to eq 'accepted'
        end

        it 'updates the listing status' do
          expect(subject.listing.status).to eq 'accepted'
        end

        it 'notifies the offer creator' do
          new_notification = Notification.last
          expect(subject.user.notifications).to eq [new_notification]
          expect(new_notification.user).to eq subject.user
        end
      end
    end

    context 'offer has no points (nil points)' do
      before do
        subject.update_attributes points: 0
        subject.accept
      end

      it 'updates the offer status to accepted' do
        expect(subject.status).to eq 'accepted'
      end

      it 'updates the listing status' do
        expect(subject.listing.status).to eq 'accepted'
      end

      it 'notifies the offer creator' do
        new_notification = Notification.last
        expect(subject.user.notifications).to eq [new_notification]
        expect(new_notification.user).to eq subject.user
      end
    end
  end

  describe '#decline' do
    before { subject.decline }

    it 'updates status to declined' do
      expect(subject.status).to eq 'declined'
    end

    it 'notifies the user' do
      new_notification = Notification.last
      expect(subject.user.notifications).to eq [new_notification]
      expect(new_notification.user).to eq subject.user
    end
  end
end
