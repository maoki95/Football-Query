class AddParentToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_reference :answers, :parent, foreign_key: { to_table: :answers }
  end
end
