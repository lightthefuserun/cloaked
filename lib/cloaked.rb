# frozen_string_literal: true

require 'active_support'

require 'cloaked/active_record/cloaked/active_record'

module Cloaked
  extend ActiveSupport::Concern

  autoload :VERSION, 'cloaked/version'

  class InvalidMethod < StandardError; end

  DEFAULT_SIZE = 8

  included do
    cattr_accessor :cloaked_fields, instance_reader: false

    before_validation :cloak_fields
  end

  class_methods do
    def with_cloaked_keys(cloaked_field, size: DEFAULT_SIZE, prefix: '', method: :url_safe)
      self.cloaked_fields ||= []
      self.cloaked_fields << {
        field_name: cloaked_field,
        size: size,
        prefix: prefix,
        method: method
      }
    end
  end

  def cloak_fields(force: false)
    self.class.cloaked_fields ||= []

    self.class.cloaked_fields.each do |field|
      cloak_field(field.merge(force: force))
    end

    self
  end

  def cloak_field(field_name: nil, size: DEFAULT_SIZE, prefix: '', force: false, method: :url_safe)
    return send(field_name) if send(field_name).present? && !force

    cloaked_value = prefix + value(method, size)

    return send("#{field_name}=", cloaked_value) unless self.class.exists?(field_name)
  end

  private

  def value(method, size)
    case method
    when :uuid then SecureRandom.uuid
    when :hex then SecureRandom.hex(size)
    when :url_safe then SecureRandom.urlsafe_base64(size)
    else raise InvalidMethod
    end
  end
end

# require 'cloaked/railtie' if defined?(Rails)
