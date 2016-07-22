describe User do
  describe 'associations' do
    subject { build(:user) }

    it 'has many exchanges' do
      expect(subject.exchanges).to eq [] # breaks when you save..
    end

    #it 'has many conversations' do # breaks when you save...
      #expect(subject.conversations).to eq []
      #subject.save
      #create(:user).send_message(subject, 'my funky message', 'my funky subject')
      #expect(subject.conversations).to_not eq []
    #end
    it { should have_many :listings }
    it { should have_many :listing_offers }
    it { should have_many :listing_asks }
    it { should have_many :listing_communities }
    it { should have_many :offers }
    it { should have_many :notifications }
    it { should have_many :reviews }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should allow_value(Faker::Address.zip_code).for :zip_code }
    it { should_not allow_value(Faker::Internet.user_name).for :zip_code }
  end

  describe '#create' do
    it 'gives the user 250 karma points' do
      expect(create(:user).points).to eq 250
    end
  end

  describe '#messages' do
    let(:sender) { create(:user) }
    let(:receiver) { create(:user) }

    context 'with a conversation' do
      before do
        sender.send_message(receiver, 'my funky message', 'my funky subject')
      end

      it 'returns the messages for a conversation' do
        expect(receiver.messages(1)).to eq [Mailboxer::Message.last]
      end
    end
  end

  describe '#url_params' do
    let(:name) { 'Jimmy Neutron' }
    subject { create(:user, name: name) }

    it 'is formatted with the user id and name' do
      expect(subject.url_params).to eq '1/Jimmy%20Neutron'
    end
  end

  describe '#user_img' do
    let(:name) { 'Bob Dylan' }
    subject { create(:user, name: name) }

    it "is formatted by the user's first initial" do
      expect(subject.user_img).to eq 'letters/b.png'
    end
  end
end
