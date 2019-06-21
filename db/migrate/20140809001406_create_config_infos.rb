# frozen_string_literal: true

class CreateConfigInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :config_infos do |t|
      t.string :key, null: false
      t.string :value, null: false
    end

    add_index :config_infos, :key, unique: true
  end
end
