require 'rails_helper'

RSpec.describe "eleitores/index", type: :view do
  before(:each) do
    assign(:eleitores, [
      Eleitor.create!(
        nome: "Nome",
        cpf: "Cpf",
        rua: "Rua",
        bairro: "Bairro",
        cep: "Cep",
        numero: "Numero",
        filiacao: "Filiacao",
        zona: "Zona",
        candidato: nil
      ),
      Eleitor.create!(
        nome: "Nome",
        cpf: "Cpf",
        rua: "Rua",
        bairro: "Bairro",
        cep: "Cep",
        numero: "Numero",
        filiacao: "Filiacao",
        zona: "Zona",
        candidato: nil
      )
    ])
  end

  it "renders a list of eleitores" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Nome".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Cpf".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Rua".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Bairro".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Cep".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Numero".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Filiacao".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Zona".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
