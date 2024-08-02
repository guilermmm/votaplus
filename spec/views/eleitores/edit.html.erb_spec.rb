require 'rails_helper'

RSpec.describe "eleitores/edit", type: :view do
  let(:eleitor) {
    Eleitor.create!(
      nome: "MyString",
      cpf: "MyString",
      rua: "MyString",
      bairro: "MyString",
      cep: "MyString",
      numero: "MyString",
      filiacao: "MyString",
      zona: "MyString",
      candidato: nil
    )
  }

  before(:each) do
    assign(:eleitor, eleitor)
  end

  it "renders the edit eleitor form" do
    render

    assert_select "form[action=?][method=?]", eleitor_path(eleitor), "post" do

      assert_select "input[name=?]", "eleitor[nome]"

      assert_select "input[name=?]", "eleitor[cpf]"

      assert_select "input[name=?]", "eleitor[rua]"

      assert_select "input[name=?]", "eleitor[bairro]"

      assert_select "input[name=?]", "eleitor[cep]"

      assert_select "input[name=?]", "eleitor[numero]"

      assert_select "input[name=?]", "eleitor[filiacao]"

      assert_select "input[name=?]", "eleitor[zona]"

      assert_select "input[name=?]", "eleitor[candidato_id]"
    end
  end
end
