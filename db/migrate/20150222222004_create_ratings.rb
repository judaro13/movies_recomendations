class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :movie_id, :limit => 8
      t.integer :value
      t.boolean :predict

      t.timestamps null: false
    end
  end
end
