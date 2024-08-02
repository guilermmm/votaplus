require 'rails_helper'

RSpec.describe "bairros/new", type: :view do
  before(:each) do
    assign(:bairro, Bairro.new(
      nome: "MyString"
    ))
  end

  it "renders new bairro form" do
    render

    assert_select "form[action=?][method=?]", bairros_path, "post" do

      assert_select "input[name=?]", "bairro[nome]"
    end
  end
end
