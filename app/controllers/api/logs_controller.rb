class Api::LogsController < ApplicationController
  #skip_before_action :verify_authenticity_token
  # GET /tasks
  def index
    puts Time.now.beginning_of_day.gmtime
    @logs = Log.where('fed_at >= ?', Time.now.beginning_of_day.gmtime).order('fed_at ASC')
  end

  # POST /logs
  def create
    @log = Log.new(log_params)

    if @log.save
      render :show, status: :created
    else
      render json: @log.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /logs/1
  def update
    @log = Log.find(params[:id])
    if @log.update(log_params)
      render :show, status: :ok
    else
      render json: @log.errors, status: :unprocessable_entity
    end
  end

  # DELETE /logs/1
  def destroy
    @log = Log.find(params[:id])
    if @log.destroy
      render :show, status: :ok
    else
      render json: @log.errors, status: :unprocessable_entity
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def log_params
      params.fetch(:log, {}).permit(
          :cat_id, :feed_id, :fed_at
      )
    end
end
