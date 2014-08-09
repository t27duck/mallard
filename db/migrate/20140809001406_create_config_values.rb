class CreateConfigValues < ActiveRecord::Migration
  def change
    create_table :config_values do |t|
      t.string :key
      t.string :value
    end

    add_index :config_values, :key, :unique => true
  end
end
