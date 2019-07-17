require_relative '../blog_app'
require 'active_model'

module BlogApp::Entities
  class Base
    include ::ActiveModel::Validations

    ATTRIBUTES = %i[
      id
      created_at
      updated_at
    ]

    def initialize(attrs = {})
      self.class::ATTRIBUTES.each do |attr|
        instance_variable_set("@#{attr}", attrs[attr]) if attrs[attr]
      end
    end

    def to_h
      self.class::ATTRIBUTES.reduce({}) do |memo, attr|
        memo[attr] = instance_variable_get("@#{attr}")
        memo
      end
    end

    def ==(other)
      return false unless other.class == self.class
      self.class::ATTRIBUTES.all? do |attr|
        self.send(attr) == other.send(attr)
      end
    end
  end
end
