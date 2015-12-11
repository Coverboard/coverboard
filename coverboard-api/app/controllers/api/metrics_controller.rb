class Api::MetricsController < Api::BaseController
  def create
    status, errors = persist_metrics

    if status
      json_ok
    else
      json_errors errors
    end
  end

  def show
    @project = Project.find_by_uid(params[:id])
    return json_errors unless @project

    render json: {
               charts: {
                   trends: [
                       MetricPresenter::Trend.new(@project, 'coverage', t('metrics.charts.trends.label_x'), t('metrics.charts.trends.label_y'))
                   ],
                   gauges: [
                        gauge('coverage'),
                        gauge('coverage-models'),
                        gauge('coverage-controllers'),
                        gauge('coverage-helpers'),
                        gauge('coverage-mailers')
                   ]
               }
           }
  end

  private
    def gauge(metric)
      MetricPresenter::Gauge.new(@project, metric, t("metrics.charts.gauges.#{metric}"))
    end

    def post_params
      params.slice(:uid, :metrics, :ts)
    end

    def persist_metrics
      metric_data = post_params
      errors = {}

      project = Project.find_by_uid(metric_data[:uid])
      return false, [t('metrics.errors.no_project')] if project.nil?

      metric_data[:metrics].each do |metric_name, metric_value|
        metric = Metric.new
        metric.project = project
        metric.name = metric_name
        metric.value = metric_value
        metric.timestamp = metric_data[:ts]

        unless metric.save
          errors[metric_name] = metric.errors
        end
      end

      return errors.empty?, errors
    end
end
