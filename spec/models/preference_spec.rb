require 'rails_helper'

RSpec.describe Preference, type: :model do

  describe '#belongs_to' do
    it 'should create the user record' do
      preference = FactoryGirl.create(:preference)
      expect do
        preference.user
      end.to change(User, :count).by(1)
    end

    it 'should get the pre-existing record' do
      user = FactoryGirl.create(:user)
      preference = FactoryGirl.create(:preference, user_id: user.id)
      expect(preference.user).to eq(user)
    end

    it 'should use the provided default attrs' do
      preference = FactoryGirl.create(:preference)
      user = preference.user_with_default_attrs
      expect(user.username).to eq('defaulted')
    end

    it 'should use the provided block' do
      preference = FactoryGirl.create(:preference)
      user = preference.user_with_block
      expect(user.username).to eq('blocked')
    end
  end

end
