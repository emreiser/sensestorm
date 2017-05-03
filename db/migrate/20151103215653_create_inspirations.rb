class CreateInspirations < ActiveRecord::Migration
  def change
    create_table :inspirations do |t|

      t.timestamps
      t.text :sense
      t.text :application
      t.text :image
    end
  end
end
