class Api::MetricsController < Api::BaseController
  def create
    metric = set_metric

    if metric.save
      json_ok
    else
      json_errors metric.errors
    end
  end

  private
    def post_params
      params.permit(:uid, :metric, :value, :ts)
    end

    def set_metric
      metric_data = post_params
      metric = Metric.new
      metric.project = Project.find_by_uid(metric_data[:uid])
      metric.name = metric_data[:metric]
      metric.value = metric_data[:value]
      metric.timestamp = metric_data[:ts]
      metric
    end
end
