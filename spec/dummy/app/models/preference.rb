class Preference < ActiveRecord::Base

  belongs_to :user
  belongs_to :user_with_default_attrs, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :user_with_block, :class_name => 'User', :foreign_key => 'user_id'

  auto_create :user
  auto_create :user_with_default_attrs, {:username => 'defaulted'}
  auto_create :user_with_block, ->(instance){
    instance.create_user(:username => 'blocked')
  }

end
