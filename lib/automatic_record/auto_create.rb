module AutomaticRecord
  module AutoCreate
    extend ActiveSupport::Concern

    included do

    end

    def get_or_auto_create_assoc(assoc, force_reload=false, default_attrs_or_block={})
      result = method(assoc).super_method.call(force_reload)
      if result.blank?
        if default_attrs_or_block.is_a?(Proc)
          result = default_attrs_or_block.call(self)
        else
          result = send("create_#{assoc}", default_attrs_or_block)
        end
      end
      return result
    end

    module ClassMethods
      def auto_create(assoc, default_attrs_or_block={})        
        reflection = reflect_on_association(assoc)
        if reflection.nil?
          raise AutomaticRecord::Error::MissingAssociation.new(assoc)
        elsif !(reflection.has_one? || reflection.belongs_to?)
          raise AutomaticRecord::Error::InvalidAssociation.new(assoc)
        else
          define_method(assoc) do |force_reload=false|
            return get_or_auto_create_assoc(assoc, force_reload, default_attrs_or_block)
          end
        end
      end
    end

  end
end
