require 'rails_helper'

describe User do
  describe 'associations' do
    # These models don't have a user_id foreign key(??), sync with ed
    # it { should have_many :conversations } # ask about mailboxer gem magic
    # it { should have_many :exchanges }
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
end
