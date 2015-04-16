module AutomaticRecord
  class Error::InvalidAssociation < StandardError
    def initialize(assoc_name)
      super("Cannot auto-create :#{assoc_name} because it is not a :has_one or :belongs_to association")
    end
  end
end
