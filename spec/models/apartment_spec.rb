require 'rails_helper'

RSpec.describe Apartment, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:bedroom) }
    it { is_expected.to validate_presence_of(:apt_type) }
    it { is_expected.to validate_presence_of(:condition) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:location) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:bedroom).only_integer.is_greater_than(0) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many_attached(:pictures) }
  end

  describe 'pictures validation' do
    let(:apartment) { build(:apartment) }
    let(:big_file) { fixture_file_upload('spec/fixtures/files/big_file.jpg', 'image/jpeg') }
    let(:text_file) { fixture_file_upload('spec/fixtures/files/text.txt', 'text/plain') }

    it 'validates pictures content type' do
      apartment.pictures.attach(text_file)
      expect(apartment).not_to be_valid
      expect(apartment.errors[:pictures]).to include('must be an image')
    end

    it 'validates pictures size' do
      apartment.pictures.attach(big_file)
      expect(apartment).not_to be_valid
      expect(apartment.errors[:pictures]).to include('is too big (should be less than 2MB)')
    end

    it 'validates maximum number of pictures' do
      6.times { apartment.pictures.attach(fixture_file_upload('spec/fixtures/files/apartment1.jpg', 'image/jpeg')) }
      expect(apartment).not_to be_valid
      expect(apartment.errors[:pictures]).to include('maximum is 5 pictures')
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:apartment)).to be_valid
    end

    it 'has a valid factory with pictures' do
      expect(build(:apartment, :with_pictures)).to be_valid
    end
  end

  describe 'scopes' do
    let!(:apartment1) { create(:apartment, price: 1000, bedroom: 1) }
    let!(:apartment2) { create(:apartment, price: 2000, bedroom: 2) }
    let!(:apartment3) { create(:apartment, price: 3000, bedroom: 3) }

    describe '.by_price' do
      it 'orders apartments by price' do
        expect(described_class.by_price(:asc)).to eq([apartment1, apartment2, apartment3])
        expect(described_class.by_price(:desc)).to eq([apartment3, apartment2, apartment1])
      end
    end

    describe '.by_bedrooms' do
      it 'filters apartments by number of bedrooms' do
        expect(described_class.by_bedrooms(2)).to eq([apartment2])
      end
    end

    describe '.by_type' do
      it 'filters apartments by type' do
        type = apartment1.apt_type
        expect(described_class.by_type(type)).to include(apartment1)
      end
    end
  end
end
