# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Typeable do
  let(:type) { create(:typeable) }

  it 'has a valid factory' do
    expect(type).to be_valid
  end

  describe 'Attributes' do
    it { should respond_to :name }
  end

  describe 'Associations' do
    it { should have_many(:pokemon_types) }
    it { should have_many(:pokemons).through(:pokemon_types) }
  end
end
