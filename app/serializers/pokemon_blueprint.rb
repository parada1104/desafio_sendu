# frozen_string_literal: true

class PokemonBlueprint < Blueprinter::Base
  identifier :id
  fields :name, :base_experience, :height, :order, :weight

  association :types, blueprint: TypeBlueprint, view: :only_name
end
