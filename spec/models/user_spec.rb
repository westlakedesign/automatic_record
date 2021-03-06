require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#has_one' do
    it 'should create the preference record' do
      user = FactoryGirl.create(:user)
      expect(Preference.find_by(user_id: user.id)).to eq(nil)
      expect do
        user.preference
      end.to change(Preference, :count).by(1)
    end

    it 'should get the pre-existing record' do
      user = FactoryGirl.create(:user)
      preference = FactoryGirl.create(:preference, user_id: user.id)
      expect(user.preference).to eq(preference)
    end

    it 'should use the provided default attrs' do
      user = FactoryGirl.create(:user)
      preference = user.preference_with_default_attrs
      expect(preference.language).to eq('en')
      expect(preference.notifications).to eq(true)
    end

    it 'should use the provided block' do
      user = FactoryGirl.create(:user)
      preference = user.preference_with_block
      expect(preference.language).to eq('fr')
      expect(preference.notifications).to eq(true)
    end
  end

  describe 'errors' do
    it 'should raise an error if the association does not exist' do
      expect do
        User.class_eval('auto_create :does_not_exist')
      end.to raise_error(AutomaticRecord::Error::MissingAssociation)
    end

    it 'should raise an error if the association is not :belongs_to or :has_one' do
      expect do
        User.class_eval do
          has_many :widgets
          auto_create :widgets
        end
      end.to raise_error(AutomaticRecord::Error::InvalidAssociation)
    end
  end

end
