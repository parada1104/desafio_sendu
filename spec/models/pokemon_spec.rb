# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Pokemon do
  let(:pokemon) { create(:pokemon) }

  it 'has a valid factory' do
    expect(pokemon).to be_valid
  end

  describe 'Attributes' do
    it { should respond_to :name }
    it { should respond_to :order }
    it { should respond_to :base_experience }
    it { should respond_to :height }
    it { should respond_to :weight }
  end

  describe 'Associations' do
    it { should have_many(:pokemon_types) }
    it { should have_many(:types).through(:pokemon_types) }
  end

  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :order }
    it { should validate_presence_of :base_experience }
    it { should validate_presence_of :height }
    it { should validate_presence_of :weight }

    it 'is invalid without a type' do
      pokemon = build(:pokemon, types: [])
      expect(pokemon).to_not be_valid
    end

    it 'is valid with a type' do
      type = create(:typeable)
      pokemon = build(:pokemon, types: [type])
      expect(pokemon).to be_valid
    end
  end
end
