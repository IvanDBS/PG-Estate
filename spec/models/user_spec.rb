require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:fullname) }
    it { is_expected.to validate_length_of(:fullname).is_at_least(2).is_at_most(50) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to allow_value('test@example.com').for(:email) }
    it { is_expected.not_to allow_value('invalid_email').for(:email) }
    it { is_expected.to allow_value('+1234567890').for(:phone) }
    it { is_expected.not_to allow_value('invalid_phone').for(:phone) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:apartments).dependent(:destroy) }
    it { is_expected.to have_one_attached(:avatar) }
  end

  describe 'avatar validation' do
    let(:user) { build(:user) }
    let(:big_file) { fixture_file_upload('spec/fixtures/files/big_file.jpg', 'image/jpeg') }
    let(:text_file) { fixture_file_upload('spec/fixtures/files/text.txt', 'text/plain') }

    it 'validates avatar content type' do
      user.avatar.attach(text_file)
      expect(user).not_to be_valid
      expect(user.errors[:avatar]).to include('must be an image')
    end

    it 'validates avatar size' do
      user.avatar.attach(big_file)
      expect(user).not_to be_valid
      expect(user.errors[:avatar]).to include('is too big (should be less than 2MB)')
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:user)).to be_valid
    end

    it 'has a valid factory with avatar' do
      expect(build(:user, :with_avatar)).to be_valid
    end

    it 'has a valid factory with apartments' do
      user = create(:user, :with_apartments)
      expect(user.apartments.count).to eq(3)
    end
  end
end
