class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.text :body,    null: false
      t.string :video
      t.string :picture
      t.string :youtube
      t.integer:status, null: false, default: 0

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
