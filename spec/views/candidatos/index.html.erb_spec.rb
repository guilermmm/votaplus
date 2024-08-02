require 'rails_helper'

RSpec.describe "candidatos/index", type: :view do
  before(:each) do
    assign(:candidatos, [
      Candidato.create!(
        nome: "Nome"
      ),
      Candidato.create!(
        nome: "Nome"
      )
    ])
  end

  it "renders a list of candidatos" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Nome".to_s), count: 2
  end
end
