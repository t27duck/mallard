class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title, :null => false
      t.string :url, :null => false
      t.string :etag, :null => false
      t.integer :sanitation_level, :null => false
      t.timestamps
    end
  end
end
