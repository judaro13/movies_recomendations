class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.string :image_url
      t.text :genders

      t.timestamps null: false
    end
  end
end
