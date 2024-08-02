class Admin::BairrosController < AdminController
    before_action :set_bairro, only: [:show, :edit, :update, :destroy]

    # GET /bairros
    def index
        unless request.format.in?(['html', 'js'])
            @bairros = Bairro.all
        end
        respond_to do |format|
            format.html
            format.json
            format.js
        end
    end

    # GET /bairros/1
    def show;end

    # GET /bairros/new
    def new
        @bairro = Bairro.new(bairro_params)
    end

    # GET /bairros/1/edit
    def edit;end

    # POST /bairros
    def create
        @bairro = Bairro.new(bairro_params)
        notice = 'Bairro cadastrado(a) com sucesso.'
        respond_to do |format|
            if @bairro.save
                remote = params.try(:[], :remote)
                location = [:admin, @bairro]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? ? location : admin_bairros_path, notice: notice}
                format.json { render :show, status: :created, location: @bairro }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @bairro.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /bairros/1
    def update
        notice = 'Bairro alterado(a) com sucesso.'
        respond_to do |format|
            if @bairro.update(bairro_params)
                remote = params.try(:[], :remote)
                location = [:admin, @bairro]
                location.unshift(params[:controller].split("/")[0].to_sym) if params[:controller].split("/").length > 1
                format.html { redirect_to remote.blank? ? location : admin_bairros_path, notice: notice}
                format.json { render :show, status: :ok, location: location }
                format.js { flash[:notice] = notice}
            else
                format.html { render :edit, status: :unprocessable_entity  }
                format.json { render json: @bairro.errors, status: :unprocessable_entity }
                format.turbo_stream { render :form_update, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /bairros/1
    def destroy
        @bairro.destroy!
        notice = 'Bairro removido(a) com sucesso.'
        respond_to do |format|
            format.html { redirect_to params[:controller].split("/").map(&:to_sym), notice: notice }
            format.json { head :no_content }
            format.js { render partial: 'shared/errors', locals: {errors: @bairro.errors} }
        end
    end

    def datatable
        respond_to do |format|
            format.json { render json: Admin::BairrosDatatable.new(view_context) }
        end
    end

    def search
        respond_to do |format|
            format.json { render json: Bairro.search(params[:search])  }
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_bairro
            @bairro = Bairro.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def bairro_params
            if params[:bairro]
                    params.require(:bairro).permit(:nome, :deleted_at)
            end
        end


end
    