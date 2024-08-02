class Admin::CandidatosController < AdminController
    before_action :set_candidato, only: [:show, :edit, :update, :destroy]

    # GET /candidatos
    def index
        unless request.format.in?(['html', 'js'])
            @candidatos = Candidato.all
        end
        respond_to do |format|
            format.html
            format.json
            format.js
        end
    end

    # GET /candidatos/1
    def show;end

    # GET /candidatos/new
    def new
        @candidato = Candidato.new(candidato_params)
    end

    # GET /candidatos/1/edit
    def edit;end

    # POST /candidatos
    def create
        @candidato = Candidato.new(candidato_params)
        notice = 'Candidato cadastrado(a) com sucesso.'
        respond_to do |format|
            if @candidato.save
                remote = params.try(:[], :remote)
                location = [:admin, @candidato]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? ? location : admin_candidatos_path, notice: notice}
                format.json { render :show, status: :created, location: @candidato }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @candidato.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /candidatos/1
    def update
        notice = 'Candidato alterado(a) com sucesso.'
        respond_to do |format|
            if @candidato.update(candidato_params)
                remote = params.try(:[], :remote)
                location = [:admin, @candidato]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? ? location : admin_candidatos_path, notice: notice}
                format.json { render :show, status: :ok, location: location }
                format.js { flash[:notice] = notice}
            else
                format.html { render :edit, status: :unprocessable_entity  }
                format.json { render json: @candidato.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /candidatos/1
    def destroy
        @candidato.destroy!
        notice = 'Candidato removido(a) com sucesso.'
        respond_to do |format|
            format.html { redirect_to params[:controller].split("/").map(&:to_sym), notice: notice }
            format.json { head :no_content }
            format.js { render partial: 'shared/errors', locals: {errors: @candidato.errors} }
        end
    end

    def datatable
        respond_to do |format|
            format.json { render json: Admin::CandidatosDatatable.new(view_context) }
        end
    end

    def search
        respond_to do |format|
            format.json { render json: Candidato.search(params[:search])  }
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_candidato
            @candidato = Candidato.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def candidato_params
            if params[:candidato]
                    params.require(:candidato).permit(:nome, :deleted_at)
            end
        end


end
    