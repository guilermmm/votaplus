require 'rails_helper'

RSpec.describe "candidatos/edit", type: :view do
  let(:candidato) {
    Candidato.create!(
      nome: "MyString"
    )
  }

  before(:each) do
    assign(:candidato, candidato)
  end

  it "renders the edit candidato form" do
    render

    assert_select "form[action=?][method=?]", candidato_path(candidato), "post" do

      assert_select "input[name=?]", "candidato[nome]"
    end
  end
end
