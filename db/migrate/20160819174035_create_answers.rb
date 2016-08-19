class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :contact, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
