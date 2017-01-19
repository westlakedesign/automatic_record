module AutomaticRecord
  class Railtie < Rails::Engine

    config.autoload_paths << "#{root}/lib"

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    initializer 'automatic_record' do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send :include, AutomaticRecord::AutoCreate
      end
    end

  end
end
