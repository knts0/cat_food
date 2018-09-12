class Api::LogsController < ApplicationController
  skip_before_action :verify_authenticity_token
  # GET /tasks
  def index
    # 後々のため、更新順で返します
    @logs = Log.where('fed_at >= ?', Time.zone.now.beginning_of_day).order('fed_at ASC') #あとでwhere条件（今日のデータのみ取得）を追加する
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
