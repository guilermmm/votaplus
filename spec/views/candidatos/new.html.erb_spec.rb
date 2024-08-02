require 'rails_helper'

RSpec.describe "candidatos/new", type: :view do
  before(:each) do
    assign(:candidato, Candidato.new(
      nome: "MyString"
    ))
  end

  it "renders new candidato form" do
    render

    assert_select "form[action=?][method=?]", candidatos_path, "post" do

      assert_select "input[name=?]", "candidato[nome]"
    end
  end
end
