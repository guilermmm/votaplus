require 'rails_helper'

RSpec.describe "bairros/edit", type: :view do
  let(:bairro) {
    Bairro.create!(
      nome: "MyString"
    )
  }

  before(:each) do
    assign(:bairro, bairro)
  end

  it "renders the edit bairro form" do
    render

    assert_select "form[action=?][method=?]", bairro_path(bairro), "post" do

      assert_select "input[name=?]", "bairro[nome]"
    end
  end
end
