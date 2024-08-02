class Admin::CandidatosDatatable
    delegate :params, :can?, :h, :t, :link_to, :button_to, :content_tag, 
            :admin_candidato_path, 
            :edit_admin_candidato_path, to: :@view
    
    
    def initialize(view)
        @view = view
        @remote = params[:remote] == 'true'
    end

    def as_json(_options = {})
        {
            draw: params[:draw].to_i,
            recordsTotal: total,
            recordsFiltered: candidatos.total_count,
            data: data
        }
    end

    private 
        def data            
            candidatos.each_with_index.map do |candidato, index|
                {
                    'index' => (index + 1) + ((page - 1) * per_page),
                                            
                                            
                            'nome' => column_nome(candidato),
                        
                                            
                                            
                            'created_at' => column_created_at(candidato),
                        
                                            
                            'updated_at' => column_updated_at(candidato),
                        
                    
                    'opcoes' => column_opcoes(candidato)
                }
            end
        end


                    
                    
                def column_nome(candidato)
                    
                        candidato.try(:nome)
                    
                end
            
                    
                    
                def column_created_at(candidato)
                    
                        candidato.try(:created_at).try(:to_fs)
                    
                end
            
                    
                def column_updated_at(candidato)
                    
                        candidato.try(:updated_at).try(:to_fs)
                    
                end
            
        

        
        def column_opcoes(candidato)
            opcoes = "<div class='sm-hero__datatable-actions'>"
            
            opcoes << (link_to(admin_candidato_path(candidato),
                { remote: @remote, class: 'btn btn-sm btn-primary text-white me-2', title: 'Visualizar',
                data: { toggle: 'tooltip', placement: 'top' } }) do
                content_tag(:i, '', class: 'bi bi-search') + ' Visualizar'
            end).to_s if can? :show, candidato

            opcoes << (link_to(edit_admin_candidato_path(candidato),
                { remote: @remote, class: 'btn btn-sm btn-warning text-dark me-2', title: 'Editar',
                data: { toggle: 'tooltip', placement: 'top' } }) do
                content_tag(:i, '', class: 'bi bi-pencil') + ' Editar'
            end).to_s if can? :edit, candidato

            opcoes <<  (button_to admin_candidato_path(candidato),
                method: :delete,
                data: { confirm: t('helpers.links.confirm_destroy', model: candidato.model_name.human), toggle: 'tooltip', placement: 'top' },
                remote: @remote,
                class: 'btn btn-sm btn-danger text-white me-2', title: 'Remover' do
                content_tag(:i, '', class: 'bi bi-trash') + ' Remover'
            end).to_s if can? :destroy, candidato

            opcoes <<  "</div>"

          
            opcoes.html_safe
        end

        def candidatos
            @candidatos ||= fetch
        end

        def query
            'Candidato'
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
            columns = ["id", "nome", "created_at", "updated_at"]
            columns[params[:order]['0'][:column].to_i]
        end

        def sort_direction
            params[:order]['0'][:dir] == 'desc' ? 'desc' : 'asc'
        end
end