class CreateCandidatos < ActiveRecord::Migration[7.1]
  def change
    create_table :candidatos, id: :uuid do |t|
      t.string :nome
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :candidatos, :deleted_at
  end
end
