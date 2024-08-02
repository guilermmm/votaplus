class AddBairroToEleitores < ActiveRecord::Migration[7.1]
  def change
    remove_column :eleitores, :bairro, :string
    add_reference :eleitores, :bairro, null: false, type: :uuid, foreign_key: true
  end
end
