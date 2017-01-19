module AutomaticRecord
  module AutoCreate
    extend ActiveSupport::Concern

    included do

    end

    module ClassMethods

      # Specifies that the given association should be created automaticaly whenever it is accessed, if
      # it does not already exist. This method should only be used on associations that are defined as
      # either :belongs_to or :has_one.
      #
      # === Example
      #
      #  class User < ActiveRecord::Base
      #    has_one :preference
      #    auto_create :preference
      #  end
      #
      # === Options
      #
      # Pass a list of default attributes:
      #  auto_create :preference, :language => 'en', :notifications => true
      #
      # Pass a block to be used for object creation:
      #  auto_create :preference, ->(user){ user.create_preference(:language => 'en', :notifications => true) }
      #
      def auto_create(assoc, default_attrs_or_block = {})
        reflection = reflect_on_association(assoc)
        if reflection.nil?
          raise AutomaticRecord::Error::MissingAssociation, assoc
        elsif !(reflection.has_one? || reflection.belongs_to?)
          raise AutomaticRecord::Error::InvalidAssociation, assoc
        else
          define_method(assoc) do |force_reload = false|
            return get_or_auto_create_assoc(assoc, force_reload, default_attrs_or_block)
          end
        end
      end
    end

    private

    def get_or_auto_create_assoc(assoc, force_reload = false, default_attrs_or_block = {}) # :nodoc:
      result = method(assoc).super_method.call(force_reload)
      if result.blank?
        result = if default_attrs_or_block.is_a?(Proc)
                   default_attrs_or_block.call(self)
                 else
                   send("create_#{assoc}", default_attrs_or_block)
                 end
      end
      return result
    end

  end
end
