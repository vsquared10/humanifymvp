require 'rails_helper'

describe Review do
  describe 'associations' do
    it { should belong_to :user }
    it { should belong_to :listing }
  end

  describe 'validations' do
    it { should validate_presence_of :recommend }
    it { should validate_presence_of :rating }

    it { should allow_value("a" * 400).for(:text) }
    it { should_not allow_value("b" * 600).for(:text) }

    it { should allow_value(100).for(:rating) }
    it { should_not allow_value("abc").for(:rating) }
    # Inclusion is a separate validation, refactor model + chat with ed
    # it { should validate_inclusion_of(:rating).in_array (1..100).to_a }
  end
end
