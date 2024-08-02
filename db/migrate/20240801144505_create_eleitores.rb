class CreateEleitores < ActiveRecord::Migration[7.1]
  def change
    create_table :eleitores, id: :uuid do |t|
      t.string :nome
      t.string :cpf
      t.string :rua
      t.string :bairro
      t.string :cep
      t.string :numero
      t.string :filiacao
      t.string :zona
      t.references :candidato, null: false, foreign_key: true, type: :uuid
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :eleitores, :deleted_at
  end
end
