class CreateAdmin < SeedMigration::Migration
  def up
    Usuario.create({nome: "Administrador", email: "admin@admin.com", permissao: "admin", password: "admin"})
  end

  def down

  end
end
