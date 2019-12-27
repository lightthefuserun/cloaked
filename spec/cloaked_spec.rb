# frozen_string_literal: true

RSpec.describe Cloaked do
  it 'has a version number' do
    expect(Cloaked::VERSION).not_to be nil
  end

  describe 'with default values' do
    subject { Post.new }

    before do
      @stubbed_base64 = SecureRandom.urlsafe_base64(Cloaked::DEFAULT_SIZE)
      allow(SecureRandom).to receive(:urlsafe_base64).and_return(@stubbed_base64)
    end

    it 'generates random string for key with SecureRandom.urlsafe_base64' do
      subject.valid?
      expect(subject.public_id).to eq(@stubbed_base64)
    end
  end

  # describe 'with :hex method' do
  #   subject { Post.new }

  #   before do
  #     @stubbed_hex = SecureRandom.hex(Cloaked::DEFAULT_SIZE)
  #     allow(SecureRandom).to receive(:hex).and_return(@stubbed_hex)
  #   end

  #   it 'generates random string for key with SecureRandom.urlsafe_base64' do
  #     subject.valid?
  #     expect(subject.public_id).to eq(@stubbed_hex)
  #   end
  # end
end
