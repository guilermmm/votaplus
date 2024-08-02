require 'rails_helper'

RSpec.describe "candidatos/show", type: :view do
  before(:each) do
    assign(:candidato, Candidato.create!(
      nome: "Nome"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nome/)
  end
end
