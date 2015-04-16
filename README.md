# AutomaticRecord

This gem allows lazy creation of `:has_one` and `:belongs_to` associations as they are accessed.

## Installation

Add the following line to your Gemfile:

    gem 'automatic_record'

Then run `bundle install` and restart your application.

## Example Usage

The example below illustrates the most basic use case.

    class User < ActiveRecord::Base
      # The  user model has a related Preference object
      has_one :preference

      # Make sure preference is created when it is first accessed
      auto_create :preference
    end

This would allow us to do something like the following in our code:

    user = User.create() # preference is currently nil
    pref = user.preference # creates preference object on the fly

## Advanced Usage

You can provide a hash of default values to the association. These will be passed in to the `create` method when the new object is created.

    class User < ActiveRecord::Base
      has_one :preference
      auto_create :preference, :language => 'en', :notifications => true
    end

Or, you can pass a lambda to perform some custom initialization. **NOTE:** The foreign key is not set for you automatically. Take care to create the associated record properly when using this method.

    class User < ActiveRecord::Base
      has_one :preference
      auto_create :preference, ->(user){
        user.create_preference(:language => 'en', :notifications => true)
      }
    end

## Testing

AutomaticRecord uses rspec for testing.

    RAILS_ENV=test rake db:create db:migrate
    rspec spec
