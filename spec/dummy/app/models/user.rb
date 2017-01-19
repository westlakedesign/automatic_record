class User < ActiveRecord::Base

  has_one :preference
  has_one :preference_with_default_attrs, class_name: 'Preference'
  has_one :preference_with_block, class_name: 'Preference'

  auto_create :preference
  auto_create :preference_with_default_attrs, language: 'en', notifications: true
  auto_create :preference_with_block, ->(instance) {
    instance.create_preference(language: 'fr', notifications: true)
  }

end
