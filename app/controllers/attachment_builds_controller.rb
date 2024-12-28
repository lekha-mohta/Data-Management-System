class AttachmentBuildsController < ApplicationController
  before_action :set_attachment_build, only: %i[show edit update destroy]

  # GET /attachment_builds
  def index
    @attachment_builds = AttachmentBuild.all
  end

  # GET /attachment_builds/1
  def show; end

  # GET /attachment_builds/new
  def new
    @attachment_build = AttachmentBuild.new
  end

  # GET /attachment_builds/1/edit
  def edit; end

  # POST /attachment_builds
  def create
    @attachment_build = AttachmentBuild.new(attachment_build_params)

    if @attachment_build.save
      redirect_to @attachment_build, notice: 'Attachment build was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /attachment_builds/1
  def update
    if @attachment_build.update(attachment_build_params)
      redirect_to @attachment_build, notice: 'Attachment build was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /attachment_builds/1
  def destroy
    @attachment_build.destroy
    redirect_to attachment_builds_url, notice: 'Attachment build was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_attachment_build
    @attachment_build = AttachmentBuild.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def attachment_build_params
    params.require(:attachment_build).permit(:attachmentId, :buildId)
  end
end
