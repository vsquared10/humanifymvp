describe Review do
  describe 'associations' do
    it { should belong_to :user }
    it { should belong_to :listing }
  end

  describe 'validations' do
    it { should validate_presence_of :recommend }
    it { should validate_presence_of :rating }
    it { should validate_length_of(:text).is_at_most(500) }
    it { should validate_numericality_of(:rating) }
    it { should validate_inclusion_of(:rating).in_range(0..100) }
  end
end
