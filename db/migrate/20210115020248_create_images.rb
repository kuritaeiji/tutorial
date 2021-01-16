class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.string :file_name
      t.string :file_type
      t.references :imageable , polymorphic: true
      t.timestamps
    end
  end
end
