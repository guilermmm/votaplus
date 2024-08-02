class Admin::EleitoresController < AdminController
  before_action :set_eleitor, only: %i[show edit update destroy]

  # GET /eleitores
  def index
    @eleitores = Eleitor.all unless request.format.in?(%w[html js])
    respond_to do |format|
      format.html
      format.json
      format.js
    end
  end

  # GET /eleitores/1
  def show; end

  # GET /eleitores/new
  def new
    @eleitor = Eleitor.new(eleitor_params)
  end

  # GET /eleitores/1/edit
  def edit; end

  # POST /eleitores
  def create
    @eleitor = Eleitor.new(eleitor_params)
    notice = 'Eleitor cadastrado(a) com sucesso.'
    respond_to do |format|
      if @eleitor.save
        remote = params.try(:[], :remote)
        location = [:admin, @eleitor]
        location.unshift(params[:controller].split('/')[0].to_sym) if params[:controller].split('/').length > 1
        format.html { redirect_to remote.blank? ? location : admin_eleitores_path, notice: }
        format.json { render :show, status: :created, location: @eleitor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @eleitor.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /eleitores/1
  def update
    notice = 'Eleitor alterado(a) com sucesso.'
    respond_to do |format|
      if @eleitor.update(eleitor_params)
        remote = params.try(:[], :remote)
        location = [:admin, @eleitor]
        location.unshift(params[:controller].split('/')[0].to_sym) if params[:controller].split('/').length > 1
        format.html { redirect_to remote.blank? ? location : admin_eleitores_path, notice: }
        format.json { render :show, status: :ok, location: }
        format.js { flash[:notice] = notice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @eleitor.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eleitores/1
  def destroy
    @eleitor.destroy!
    notice = 'Eleitor removido(a) com sucesso.'
    respond_to do |format|
      format.html { redirect_to params[:controller].split('/').map(&:to_sym), notice: }
      format.json { head :no_content }
      format.js { render partial: 'shared/errors', locals: { errors: @eleitor.errors } }
    end
  end

  def datatable
    respond_to do |format|
      format.json { render json: Admin::EleitoresDatatable.new(view_context) }
    end
  end

  def search
    respond_to do |format|
      format.json { render json: Eleitor.search(params[:search]) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_eleitor
    @eleitor = Eleitor.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def eleitor_params
    return unless params[:eleitor]

    params.require(:eleitor).permit(:nome, :cpf, :rua, :bairro_id, :cep, :numero, :filiacao, :zona,
                                    :candidato_id, :deleted_at)
  end
end
