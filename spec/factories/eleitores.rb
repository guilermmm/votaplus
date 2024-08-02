FactoryBot.define do
  factory :eleitor do
    nome { "MyString" }
    cpf { "MyString" }
    rua { "MyString" }
    bairro { "MyString" }
    cep { "MyString" }
    numero { "MyString" }
    filiacao { "MyString" }
    zona { "MyString" }
    candidato { nil }
    deleted_at { "2024-08-01 11:45:05" }
  end
end
