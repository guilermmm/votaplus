class CreateBairros < ActiveRecord::Migration[7.1]
  def change
    create_table :bairros, id: :uuid do |t|
      t.string :nome
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :bairros, :deleted_at
  end
end
