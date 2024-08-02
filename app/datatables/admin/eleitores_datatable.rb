class Admin::EleitoresDatatable
  delegate :params, :can?, :h, :t, :link_to, :button_to, :content_tag,
           :admin_eleitor_path,
           :edit_admin_eleitor_path, to: :@view

  def initialize(view)
    @view = view
    @remote = params[:remote] == 'true'
  end

  def as_json(_options = {})
    {
      draw: params[:draw].to_i,
      recordsTotal: total,
      recordsFiltered: eleitores.total_count,
      data:
    }
  end

  private

  def data
    eleitores.each_with_index.map do |eleitor, index|
      {
        'index' => (index + 1) + ((page - 1) * per_page),

        'nome' => column_nome(eleitor),

        'cpf' => column_cpf(eleitor),

        'rua' => column_rua(eleitor),

        'bairro' => column_bairro(eleitor),

        'cep' => column_cep(eleitor),

        'numero' => column_numero(eleitor),

        'filiacao' => column_filiacao(eleitor),

        'zona' => column_zona(eleitor),

        'candidato_id' => column_candidato_id(eleitor),

        'created_at' => column_created_at(eleitor),

        'updated_at' => column_updated_at(eleitor),

        'opcoes' => column_opcoes(eleitor)
      }
    end
  end

  def column_nome(eleitor)
    eleitor.try(:nome)
  end

  def column_cpf(eleitor)
    eleitor.try(:cpf)
  end

  def column_rua(eleitor)
    eleitor.try(:rua)
  end

  def column_bairro(eleitor)
    eleitor.try(:bairro).try(:nome)
  end

  def column_cep(eleitor)
    eleitor.try(:cep)
  end

  def column_numero(eleitor)
    eleitor.try(:numero)
  end

  def column_filiacao(eleitor)
    eleitor.try(:filiacao)
  end

  def column_zona(eleitor)
    eleitor.try(:zona)
  end

  def column_candidato_id(eleitor)
    eleitor.try(:candidato).try(:nome)
  end

  def column_created_at(eleitor)
    eleitor.try(:created_at).try(:to_fs)
  end

  def column_updated_at(eleitor)
    eleitor.try(:updated_at).try(:to_fs)
  end

  def column_opcoes(eleitor)
    opcoes = "<div class='sm-hero__datatable-actions'>"

    if can? :show, eleitor
      opcoes << (link_to(admin_eleitor_path(eleitor),
                         { remote: @remote, class: 'btn btn-sm btn-primary text-white me-2', title: 'Visualizar',
                           data: { toggle: 'tooltip', placement: 'top' } }) do
                   content_tag(:i, '', class: 'bi bi-search') + ' Visualizar'
                 end).to_s
    end

    if can? :edit, eleitor
      opcoes << (link_to(edit_admin_eleitor_path(eleitor),
                         { remote: @remote, class: 'btn btn-sm btn-warning text-dark me-2', title: 'Editar',
                           data: { toggle: 'tooltip', placement: 'top' } }) do
                   content_tag(:i, '', class: 'bi bi-pencil') + ' Editar'
                 end).to_s
    end

    if can? :destroy, eleitor
      opcoes << (button_to admin_eleitor_path(eleitor),
                           method: :delete,
                           data: { confirm: t('helpers.links.confirm_destroy', model: eleitor.model_name.human), toggle: 'tooltip', placement: 'top' },
                           remote: @remote,
                           class: 'btn btn-sm btn-danger text-white me-2', title: 'Remover' do
                   content_tag(:i, '', class: 'bi bi-trash') + ' Remover'
                 end).to_s
    end

    opcoes << '</div>'

    opcoes.html_safe
  end

  def eleitores
    @eleitores ||= fetch
  end

  def query
    'Eleitor'
  end

  def fetch
    str_query = query
    params[:columns].each do |column|
      str_query << ".where(#{column[1][:data]}: '#{column[1][:search][:value]}')" if column[1][:search][:value].present?
    end
    str_query << '.search(params[:search][:value])' if params[:search][:value].present?
    str_query << %{.order("#{sort_column}" => "#{sort_direction}").page(page).per(per_page)}
    eval str_query
  end

  def total
    str_query = query
    str_query << '.count'
    eval str_query
  end

  def page
    params[:start].to_i / per_page + 1
  end

  def per_page
    params[:length].to_i.positive? ? params[:length].to_i : 10
  end

  def sort_column
    columns = %w[id nome cpf rua bairro cep numero filiacao zona candidato_id
                 created_at updated_at]
    columns[params[:order]['0'][:column].to_i]
  end

  def sort_direction
    params[:order]['0'][:dir] == 'desc' ? 'desc' : 'asc'
  end
end
