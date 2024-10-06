class ConvertAllTablesToUuid < ActiveRecord::Migration[7.2]
  def up
    # Disable foreign key checks
    execute "SET CONSTRAINTS ALL DEFERRED"

    # Remove existing foreign keys
    remove_foreign_key :product_ideas, :users if foreign_key_exists?(:product_ideas, :users)
    remove_foreign_key :prds, :product_ideas if foreign_key_exists?(:prds, :product_ideas)

    # Convert users table
    add_column :users, :uuid, :uuid, default: 'gen_random_uuid()', null: false
    execute "UPDATE users SET uuid = gen_random_uuid()"
    change_column_null :users, :uuid, false
    execute "ALTER TABLE users DROP CONSTRAINT users_pkey CASCADE"
    execute "ALTER TABLE users DROP COLUMN id"
    execute "ALTER TABLE users RENAME COLUMN uuid TO id"
    execute "ALTER TABLE users ADD PRIMARY KEY (id)"

    # Convert product_ideas table
    add_column :product_ideas, :uuid, :uuid, default: 'gen_random_uuid()', null: false
    execute "UPDATE product_ideas SET uuid = gen_random_uuid()"
    change_column_null :product_ideas, :uuid, false
    add_column :product_ideas, :user_uuid, :uuid
    execute <<-SQL
      UPDATE product_ideas
      SET user_uuid = users.id
      FROM users
      WHERE product_ideas.user_id::text = users.id::text
    SQL
    execute "ALTER TABLE product_ideas DROP CONSTRAINT product_ideas_pkey CASCADE"
    execute "ALTER TABLE product_ideas DROP COLUMN id"
    execute "ALTER TABLE product_ideas DROP COLUMN user_id"
    execute "ALTER TABLE product_ideas RENAME COLUMN uuid TO id"
    execute "ALTER TABLE product_ideas RENAME COLUMN user_uuid TO user_id"
    execute "ALTER TABLE product_ideas ADD PRIMARY KEY (id)"

    # Convert prds table
    add_column :prds, :uuid, :uuid, default: 'gen_random_uuid()', null: false
    execute "UPDATE prds SET uuid = gen_random_uuid()"
    change_column_null :prds, :uuid, false
    add_column :prds, :product_idea_uuid, :uuid
    execute <<-SQL
      UPDATE prds
      SET product_idea_uuid = product_ideas.id
      FROM product_ideas
      WHERE prds.product_idea_id::text = product_ideas.id::text
    SQL
    execute "ALTER TABLE prds DROP CONSTRAINT prds_pkey CASCADE"
    execute "ALTER TABLE prds DROP COLUMN id"
    execute "ALTER TABLE prds DROP COLUMN product_idea_id"
    execute "ALTER TABLE prds RENAME COLUMN uuid TO id"
    execute "ALTER TABLE prds RENAME COLUMN product_idea_uuid TO product_idea_id"
    execute "ALTER TABLE prds ADD PRIMARY KEY (id)"

    # Add new foreign key constraints
    add_foreign_key :product_ideas, :users
    add_foreign_key :prds, :product_ideas

    # Re-enable foreign key checks
    execute "SET CONSTRAINTS ALL IMMEDIATE"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
