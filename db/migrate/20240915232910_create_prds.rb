class CreatePrds < ActiveRecord::Migration[7.2]
  def change
    create_table :prds do |t|
      t.string :title
      t.text :content
      t.references :product_idea, null: false, foreign_key: true

      t.timestamps
    end
  end
end
