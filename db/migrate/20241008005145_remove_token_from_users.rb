# frozen_string_literal: true

class RemoveTokenFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :token, :string, null: false
  end
end
