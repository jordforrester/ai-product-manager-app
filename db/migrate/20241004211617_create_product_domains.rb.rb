class CreateProductDomains < ActiveRecord::Migration[7.2]
  def change
    create_table :product_domains, id: :uuid do |t|
      t.string :name
      t.text :description
      t.references :user, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
