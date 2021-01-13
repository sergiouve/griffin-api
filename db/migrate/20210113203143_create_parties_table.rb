class CreatePartiesTable < ActiveRecord::Migration[6.1]
  def change
    create_table :parties_tables do |table|
      table.string :name, null: false
      table.string :hash
      table.datetime :ends_at
      table.timestamps
    end
  end
end
