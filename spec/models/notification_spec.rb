require 'rails_helper'

describe Notification do
  it { should belong_to :user }

  describe 'validations' do
    it { should validate_presence_of :message }
    it { should validate_presence_of :url }
  end
end
