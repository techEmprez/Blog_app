class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :photo
<<<<<<<< HEAD:db/migrate/20221122232956_create_users.rb
      t.string :bio
========
      t.text :bio
      t.integer :posts_counter, default: 0
>>>>>>>> 70bedf69eb39c081f69c284362546932b5ecd313:db/migrate/20221122144333_create_users.rb

      t.timestamps
    end
  end
end
