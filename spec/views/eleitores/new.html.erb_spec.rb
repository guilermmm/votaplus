require 'rails_helper'

RSpec.describe "eleitores/new", type: :view do
  before(:each) do
    assign(:eleitor, Eleitor.new(
      nome: "MyString",
      cpf: "MyString",
      rua: "MyString",
      bairro: "MyString",
      cep: "MyString",
      numero: "MyString",
      filiacao: "MyString",
      zona: "MyString",
      candidato: nil
    ))
  end

  it "renders new eleitor form" do
    render

    assert_select "form[action=?][method=?]", eleitores_path, "post" do

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
