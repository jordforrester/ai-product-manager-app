class AddUserToProductIdeas < ActiveRecord::Migration[7.0]
  def up
    add_reference :product_ideas, :user, null: true, foreign_key: true
    
    # If you have a default user or want to assign all existing product ideas to a specific user, 
    # you can uncomment and modify the following lines:
    # default_user = User.first
    # ProductIdea.update_all(user_id: default_user.id) if default_user

    # If you want to make the column non-nullable after assigning users, uncomment this line:
    # change_column_null :product_ideas, :user_id, false
  end

  def down
    remove_reference :product_ideas, :user
  end
end
