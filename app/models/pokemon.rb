class Pokemon < ApplicationRecord
  has_many :pokemon_types
  has_many :types, through: :pokemon_types, source: :typeable

  validates :name, :order, :base_experience, :height, :weight, presence: true
  validate :pokemon_type_validation

  private

  def pokemon_type_validation
    at_least_one_type
  end

  def at_least_one_type
    errors.add(:types, 'must have at least one type') if types.empty?
  end
end
