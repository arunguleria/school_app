class AttachmentsController < ApplicationController
  
  before_action :get_teacher
  before_action :set_attachment, only: [:show, :edit, :update, :destroy, :download]

  # GET /attachments
  # GET /attachments.json
  def index
    @attachments = @teacher.attachments
  end

  # GET /attachments/1
  # GET /attachments/1.json
  def show
  end

  def download
    send_file(@attachment.asset.path, filename: @attachment.asset_file_name, content_type: @attachment.asset_content_type, disposition: 'attachment')
  end

  # GET /attachments/new
  def new
    @attachment = Attachment.new
  end

  # GET /attachments/1/edit
  def edit
  end

  # POST /attachments
  # POST /attachments.json
  def create
    @attachment = @teacher.attachments.new(attachment_params)
    
    respond_to do |format|
      if @attachment.save
        format.html { redirect_to [@teacher, @attachment], notice: 'Attachment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @attachment }
      else
        format.html { render action: 'new' }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attachments/1
  # PATCH/PUT /attachments/1.json
  def update
    respond_to do |format|
      if @attachment.update(attachment_params)
        format.html { redirect_to [@teacher, @attachment], notice: 'Attachment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.json
  def destroy
    @attachment.destroy
    respond_to do |format|
      format.html { redirect_to teacher_attachments_url }
      format.json { head :no_content }
    end
  end

  private
    def get_teacher
      @teacher = Teacher.where(id: params[:teacher_id]).first
      access_denied unless @teacher
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_attachment
      @attachment = @teacher.attachments.where(id: params[:id]).first
      access_denied unless @attachment
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attachment_params
      params.require(:attachment).permit(:asset)
    end
end
