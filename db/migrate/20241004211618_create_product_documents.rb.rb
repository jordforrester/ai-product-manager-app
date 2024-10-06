class CreateProductDocuments < ActiveRecord::Migration[7.2]
  def change
    create_table :product_documents, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.text :file_data

      t.timestamps
    end
  end
end
