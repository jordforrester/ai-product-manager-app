class AddStatusToPrds < ActiveRecord::Migration[7.2]
  def change
    add_column :prds, :status, :string
  end
end
