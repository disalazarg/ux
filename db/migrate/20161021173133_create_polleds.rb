class CreatePolleds < ActiveRecord::Migration
  def change
    create_table :polleds do |t|
      t.references :poll, index: true, foreign_key: true
      t.references :contact, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
