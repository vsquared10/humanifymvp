describe Listing do
  subject { build(:listing) }
  let(:user) { create(:user) }

  before do
    allow(Pusher).to receive(:trigger) # find better way to mock notif actions
  end

  describe 'associations' do
    #it { should have_many :exchanges } doesn't work
    #it { should have_many :claims } doesn't work
    it { should have_many :offers }
    it { should have_many :reviews }
    it { should belong_to :user }
    it { should have_attached_file :image }
  end

  describe 'validations' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:visibility) }
    it { should validate_presence_of(:image) }
 		it do
			should validate_attachment_content_type(:image).
							allowing('image/png', 'image/gif').
							rejecting('text/plain', 'text/xml')
    end
    it do
      should validate_inclusion_of(:type).
              in_array ['ListingAsk', 'ListingOffer', 'ListingCommunity']
    end
    it do
      should validate_inclusion_of(:status).
              in_array ['pending', 'accepted', 'closed']
    end
    it do
      should validate_inclusion_of(:visibility).
              in_array ['global', 'local']
    end
  end

  describe 'saving' do
    let(:zip_code) { 10025 }
    let(:location_name) { "New York" }

    before do
      subject.user.zip_code = zip_code
    end

    it 'sets location' do
      expect(subject).to be_valid
      subject.save
      expect(subject.location).to eq location_name
    end
  end

  describe 'parts' do
    it 'defaults to the first part' do
      expect(subject.form_part).to eq 'type'
    end

    # note: parts aren't validated
    it 'allows the form part to be set' do
      subject.form_part = 'offer'
      expect(subject.form_part).to eq 'offer'
      subject.form_part = 'default'
      expect(subject.form_part).to eq 'default'
    end
  end

  describe '.open_global' do
    let!(:global_listing) do
      create(:listing, visibility: 'global', status: 'accepted')
      Listing.last
    end

    let!(:local_listing) do
     create(:listing, visibility: 'local', status: 'accepted')
     Listing.last
    end

    let!(:pending_listing) do
      create(:listing, visibility: 'local', status: 'pending')
      Listing.last
    end

    it 'returns all (globally visible or pending) listings' do
      results = Listing.open_global
      expect(results).to include global_listing
      expect(results).to_not include local_listing
      expect(results).to include pending_listing
    end
  end

  describe 'taggablity' do
    let(:some_tag) { Faker::Lorem.word }

    it 'has taggable topics' do
      subject.topic_list.add some_tag
      subject.save
      subject.reload
      expect(subject.topic_list).to eq [some_tag]
    end
  end


  describe 'messageability' do
    let(:other_listing) { create(:listing) }
    let(:message_subject) { Faker::Lorem.sentence }
    let(:message_body) { Faker::Lorem.sentence }
    let(:message_body_2) { 'foobar' }
    before { subject.save }

    it 'can send and receive messages' do
      sent_receipt = subject.send_message(other_listing, message_subject, message_body)
      reply_receipt = other_listing.reply_to_sender(sent_receipt, message_body_2)

      subject_mailbox = subject.mailbox.inbox.first
      expect(subject.messages.first).to eq sent_receipt.message
      expect(subject_mailbox.messages.last).to eq reply_receipt.message

      receiving_mailbox = other_listing.mailbox.inbox.first
      expect(other_listing.messages.first).to eq reply_receipt.message
      expect(receiving_mailbox.messages.first).to eq sent_receipt.message
    end
  end

  describe '#duration' do
    it 'is a number treated as a number of days' do
      subject.duration = 2
      expect(subject.duration.days).to eq 2.days
    end
  end

  describe '#expiration' do
    context 'without a duration' do
      it 'is nil' do
        subject.duration = nil
        expect(subject.expiration).to be_nil
      end
    end

    context 'with a duration' do
      let(:created_date) { Date.yesterday }
      let(:duration) { 2 }

      it 'is the created date plus the duration days' do
        subject.created_at = created_date
        subject.duration = duration
        expect(subject.expiration).to eq created_date.plus_with_duration duration
      end
    end
  end

  describe '#expired?' do
    context 'duration is nil' do
      it 'is nil' do
        subject.duration = nil
        expect(subject.expired?).to be_nil
      end
    end

    context 'duration is set' do
      before do
        subject.created_at = Date.yesterday
      end

      context 'expiration day is after today' do
        before do
          subject.duration = 2
        end

        it 'is false' do
          expect(subject.expired?).to be false
        end
      end

      context 'expiration day is before today' do
        before do
          subject.duration = 1
        end

        it 'is true' do
          expect(subject.expired?).to be true
        end
      end
    end
  end

  describe '#days_left' do
    context 'duration is nil' do
      it 'is nil' do
        subject.duration = nil
        expect(subject.days_left).to be_nil
      end
    end

    context 'duration is set' do
      before do
        subject.created_at = Date.today
      end

      it 'is a formatted string of days left from expiration date' do
        subject.duration = 3
        expect(subject.days_left).to eq "3 days"
        subject.duration = 1
        expect(subject.days_left).to eq "1 day"
      end
    end
  end

  describe '#closed?' do
    it 'reflects the status' do
      subject.status = 'pending'
      expect(subject.closed?).to be false
      subject.status = 'accepted'
      expect(subject.closed?).to be true
      subject.status = 'closed'
      expect(subject.closed?).to be true
    end
  end

  describe '#accepted?' do
    it 'reflects the status' do
      subject.status = 'pending'
      expect(subject.accepted?).to be false
      subject.status = 'closed'
      expect(subject.accepted?).to be false
      subject.status = 'accepted'
      expect(subject.accepted?).to be true
    end
  end

  describe '#accepted_user' do
    context 'without an accepted offer' do
      it 'blows up' do # note: bad thing(tm)
        expect{
          subject.accepted_user
        }.to raise_error NoMethodError
      end
    end

    context 'with an accepted offer' do
      let(:offer) { create(:offer, user: user, listing: subject) }

      before do
        offer.accept
      end

      it 'returns the user of the accepted offer' do
        expect(subject.accepted_user).to eq user
      end
    end
  end

  describe '#valid_offers' do
    let!(:offer) { create(:offer, user: user, listing: subject) }
    let!(:accepted_offer) { create(:offer, user: user, listing: subject, status: 'accepted') }

    it 'returns pending offers' do
      expect(subject.valid_offers).to match_array [offer]
    end
  end

  describe '#highest_offer' do
    let!(:first_offer) { create(:offer, points: 10, listing: subject) }
    let!(:second_offer) { create(:offer, points: 50, listing: subject) }

    it 'returns the offer with the highest points' do
      expect(subject.highest_offer).to eq second_offer
    end
  end

  describe '#points_starting' do
    context 'with a valid offer' do
      let!(:first_offer) { create(:offer, points: 10, listing: subject) }
      let!(:second_offer) { create(:offer, points: 50, listing: subject) }

      it 'returns the highest offer points' do
        expect(subject.points_starting).to eq second_offer.points
      end
    end

    context 'with no valid offers' do
      it 'returns the listing points' do
        expect(subject.points_starting).to eq subject.points
      end
    end
  end

  describe '#posted_by?' do
    context 'user is listing user' do
      it 'is true' do
        expect(subject.posted_by?(subject.user)).to be true
      end
    end

    context 'user is not listing user' do
      let(:user) { build(:user) }

      it 'is false' do
        expect(subject.posted_by?(user)).to be false
      end
    end
  end
end
