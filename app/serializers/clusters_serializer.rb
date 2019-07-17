class ClustersSerializer
  def initialize(object)
    @object = object
  end

  def as_json
    hash = @object.to_h
    hash[:kind] = @object.class.to_s.demodulize.underscore
    hash[:created_at] = @object.created_at.to_s(:db)
    hash
  end
end
