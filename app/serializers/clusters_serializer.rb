class ClustersSerializer
  def initialize(object)
    @object = object
  end

  def as_json
    @object.to_h.tap do |result|
      result[:kind] = @object.class.to_s.demodulize.underscore
      result[:created_at] = @object.created_at.to_s(:db)
    end
  end
end
