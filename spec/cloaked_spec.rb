# frozen_string_literal: true

RSpec.describe Cloaked do
  it 'has a version number' do
    expect(Cloaked::VERSION).not_to be nil
  end

  describe 'with default values' do
    subject { PostWithDefaultOptions.new }

    before do
      @stubbed_base64 = SecureRandom.urlsafe_base64(Cloaked::DEFAULT_SIZE)
      allow(SecureRandom).to receive(:urlsafe_base64).and_return(@stubbed_base64)
    end

    it 'generates random string for key with SecureRandom.urlsafe_base64' do
      subject.valid?
      expect(subject.public_id).to eq(@stubbed_base64)
    end
  end

  describe 'with :hex method option' do
    subject { PostWithHexOption.new }

    before do
      @stubbed_hex = SecureRandom.hex(Cloaked::DEFAULT_SIZE)
      allow(SecureRandom).to receive(:hex).and_return(@stubbed_hex)
    end

    it 'generates random string for key with SecureRandom.hex' do
      subject.valid?
      expect(subject.public_id).to eq(@stubbed_hex)
    end
  end

  describe 'with :uuid method option' do
    subject { PostWithUuidOption.new }

    before do
      @stubbed_uuid = SecureRandom.uuid
      allow(SecureRandom).to receive(:uuid).and_return(@stubbed_uuid)
    end

    it 'generates random string for key with SecureRandom.uuid' do
      subject.valid?
      expect(subject.public_id).to eq(@stubbed_uuid)
    end
  end

  describe 'with size option' do
    subject { PostWithSizeOption.new }

    it 'generates random string with a custom length' do
      subject.valid?
      expect(subject.public_id.length).to eq(32)
    end
  end

  describe 'with prefix option' do
    subject { PostWithPrefixOption.new }

    it 'generates random string that starts with the prefix' do
      subject.valid?
      expect(subject.public_id).to start_with('CLK.')
    end
  end

  describe 'with an array of keys' do
    subject { PostWithArrayOfKeys.new }

    before { subject.valid? }

    it 'generates a random string for each key' do
      expect(subject.public_id).to be_present
      expect(subject.public_thread_id).to be_present
    end

    it 'generates unique values for each key' do
      expect(subject.public_id).not_to eq(subject.public_thread_id)
    end

    it 'generates accepts options' do
      expect(subject.public_id.length).to eq(36)
      expect(subject.public_thread_id.length).to eq(36)
    end
  end
end
