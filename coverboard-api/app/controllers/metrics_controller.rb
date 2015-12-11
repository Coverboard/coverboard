class MetricsController < ApplicationController
  def create
    metric_data = post_params

    metric = Metric.new
    metric.project = find_project(metric_data[:uid])
    metric.name = metric_data[:metric]
    metric.value = metric_data[:value]
    metric.timestamp = metric_data[:ts]

    if metric.save
      json_response 'OK'
    else
      json_response 'ERROR', metric.errors
    end
  end

  private
  def post_params
    params.permit(:uid, :metric, :value, :ts)
  end

  def find_project(uid)
    Project.where({uid: uid}).limit(1).first
  end

  def json_response(status, payload = [])
    render json: {
               status: status,
               payload: payload
   }
  end
end
