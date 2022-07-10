require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:calendar) }
  end
end
