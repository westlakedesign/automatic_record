module AutomaticRecord
  class Error::MissingAssociation < StandardError
    def initialize(assoc_name)
      super("Attempted to auto_create non-existent :#{assoc_name} association")
    end
  end
end
