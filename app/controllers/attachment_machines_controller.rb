class AttachmentMachinesController < ApplicationController
  before_action :set_attachment_process, only: %i[show edit update destroy]

  # GET /attachment_processes
  def index
    @attachment_processes = AttachmentProcess.all
  end

  # GET /attachment_processes/1
  def show; end

  # GET /attachment_processes/new
  def new
    @attachment_process = AttachmentProcess.new
  end

  # GET /attachment_processes/1/edit
  def edit; end

  # POST /attachment_processes
  def create
    @attachment_process = AttachmentProcess.new(attachment_process_params)

    if @attachment_process.save
      redirect_to @attachment_process, notice: 'Attachment process was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /attachment_processes/1
  def update
    if @attachment_process.update(attachment_process_params)
      redirect_to @attachment_process, notice: 'Attachment process was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /attachment_processes/1
  def destroy
    @attachment_process.destroy
    redirect_to attachment_processes_url, notice: 'Attachment process was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_attachment_process
    @attachment_process = AttachmentProcess.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def attachment_process_params
    params.require(:attachment_process).permit(:attachmentId, :processId)
  end
end
