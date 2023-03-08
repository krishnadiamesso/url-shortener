class CreateUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :urls, id: :uuid do |t|
      t.string :long_url
      t.string :short_url, unique: true
      t.integer :click, default: 0

      t.timestamps
    end

    add_index :urls, :short_url, unique: true
  end
end
