class CreateBatchesContacts < ActiveRecord::Migration
  def change
    create_table :batches_contacts do |t|
      t.references :batch, index: true, foreign_key: true
      t.references :contact, index: true, foreign_key: true
    end
  end
end
