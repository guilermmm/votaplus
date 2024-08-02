require 'rails_helper'

RSpec.describe "eleitores/show", type: :view do
  before(:each) do
    assign(:eleitor, Eleitor.create!(
      nome: "Nome",
      cpf: "Cpf",
      rua: "Rua",
      bairro: "Bairro",
      cep: "Cep",
      numero: "Numero",
      filiacao: "Filiacao",
      zona: "Zona",
      candidato: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nome/)
    expect(rendered).to match(/Cpf/)
    expect(rendered).to match(/Rua/)
    expect(rendered).to match(/Bairro/)
    expect(rendered).to match(/Cep/)
    expect(rendered).to match(/Numero/)
    expect(rendered).to match(/Filiacao/)
    expect(rendered).to match(/Zona/)
    expect(rendered).to match(//)
  end
end
