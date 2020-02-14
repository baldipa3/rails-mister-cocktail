class AddUserToCocktails < ActiveRecord::Migration[5.2]
  def change
    add_reference :cocktails, :user, foreign_key: true
  end
end
