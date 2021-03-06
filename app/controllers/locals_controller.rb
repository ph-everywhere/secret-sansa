class LocalsController < ApplicationController
  before_action :set_local, only: [:show, :edit, :update, :destroy]

  # GET /locals
  # GET /locals.json
  def index
    @locals = Local.paginate(:page => params[:page])

    respond_to do |format|
      format.html { render action: 'index' }
      format.json { render :json => {
          :amount => @locals.length,
          :success => true,
          :html => (render_to_string partial: 'index_part.html.haml')}
      }
    end
  end

  # GET /locals/1
  # GET /locals/1.json
  def show
    respond_to do |format|
      format.html { render action: 'show' }
      format.json { render :json => {
          :html => (render_to_string 'locals/show.html.haml', :layout => false )}
      }
    end
  end

  # GET /locals/new
  def new
    @local = Local.new
  end

  # GET /locals/1/edit
  def edit
  end

  # POST /locals
  # POST /locals.json
  def create
    @local = Local.new(local_params)

    respond_to do |format|
      if @local.save
        format.html { redirect_to @local, success: 'Local foi criado com sucesso!' }
        format.json { render action: 'show', status: :created, location: @local }
      else
        format.html { render action: 'new' }
        format.json { render json: @local.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locals/1
  # PATCH/PUT /locals/1.json
  def update
    respond_to do |format|
      if @local.update(local_params)
        format.html { redirect_to @local, notice: 'Local was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @local.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locals/1
  # DELETE /locals/1.json
  def destroy
    @local.destroy
    respond_to do |format|
      format.html { redirect_to locals_url }
      format.json { head :no_content }
    end
  end

  def hierarchy_picker
    if params[:root_local_id].nil?
      @root_locals = [Local.find(1245)] #Local.roots
    else
      @root_locals = [Local.find(params[:root_local_id])]
    end

    respond_to do |format|
      format.json { render json: { :html => render_to_string("locals/hierarchy_picker.html.haml", :layout => false) } }
      format.html {}
    end
  end

  def hierarchy_view
    if params[:root_local_id].nil?
      @root_locals = Local.roots
    else
      @root_locals = [Local.find(params[:root_local_id])]
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_local
      @local = Local.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def local_params
      params.require(:local).permit(:name, :category, :address, :city, :state, :cep, :cnpj, :company_name)
    end
end
