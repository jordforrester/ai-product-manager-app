# db/migrate/[timestamp]_add_prd_context_to_product_ideas.rb
class AddPrdContextToProductIdeas < ActiveRecord::Migration[7.2]
  def change
    add_column :product_ideas, :customer_acv, :decimal, precision: 10, scale: 2
    add_column :product_ideas, :customer_impact, :string
    add_column :product_ideas, :tshirt_size_effort, :string
  end
end
