require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:calendars) }
    it { is_expected.to have_many(:events).through(:calendars) }
  end
end
