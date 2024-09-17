class CreateProductIdeas < ActiveRecord::Migration[7.2]
  def change
    create_table :product_ideas do |t|
      t.string :title
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
