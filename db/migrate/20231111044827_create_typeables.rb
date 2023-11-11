class CreateTypeables < ActiveRecord::Migration[7.0]
  def change
    create_table :typeables do |t|
      t.string :name

      t.timestamps
    end
  end
end
