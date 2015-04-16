require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#has_one' do
    it 'should create the preference record' do
      user = FactoryGirl.create(:user)
      expect(Preference.find_by(:user_id => user.id)).to eq(nil)
      expect{
        user.preference
      }.to change(Preference, :count).by(1)
    end

    it 'should get the pre-existing record' do
      user = FactoryGirl.create(:user)
      preference = FactoryGirl.create(:preference, :user_id => user.id)
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

    it 'should reload the record from the database' do
      user = FactoryGirl.create(:user)
      preference = user.preference

      preference_alt = Preference.find_by(:id => preference.id)
      preference_alt.update_attribute(:language, 'ca')

      expect(user.preference.language).to_not eq('ca')
      expect(user.preference(true).language).to eq('ca')
    end
  end

  describe 'errors' do
    it 'should raise an error if the association does not exist' do
      expect{
        User.class_eval('auto_create :does_not_exist')
      }.to raise_error(AutomaticRecord::Error::MissingAssociation)
    end

    it 'should raise an error if the association is not :belongs_to or :has_one' do
      expect{
        User.class_eval do
          has_many :widgets
          auto_create :widgets
        end
      }.to raise_error(AutomaticRecord::Error::InvalidAssociation)
    end
  end

end
