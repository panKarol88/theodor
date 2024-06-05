class CreateDataCrumbs < ActiveRecord::Migration[7.1]
  def change
    create_table :data_crumbs do |t|
      t.text :content, null: false

      t.timestamps
    end
  end
end
