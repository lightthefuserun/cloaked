# frozen_string_literal: true

RSpec.describe Cloaked do
  class ModelWithDefaultValues < ActiveRecord::Base
    include Cloaked

    with_cloaked_keys :public_id
  end

  it 'has a version number' do
    expect(Cloaked::VERSION).not_to be nil
  end

  describe 'with default values' do
    subject { ModelWithDefaultValues.new }

    it 'generates random string for key with SecureRandom.urlsafe_base64' do
      subject.valid?
      expect(subject.public_id).be nil
    end
  end
end
