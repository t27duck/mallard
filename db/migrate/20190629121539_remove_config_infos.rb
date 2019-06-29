# frozen_string_literal: true

class RemoveConfigInfos < ActiveRecord::Migration[6.0]
  def up
    drop_table :config_infos
  end

  def down
    create_table :config_infos do |t|
      t.string :key, null: false
      t.string :value, null: false
      t.index ["key"], name: "index_config_infos_on_key", unique: true
    end
  end
end
