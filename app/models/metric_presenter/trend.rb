module MetricPresenter
  class Trend
    attr_accessor :data, :label

    def initialize(project, metric_name, label_x, label_y)
      data = project.metrics.named(metric_name).for_trends

      self.data = data.map { |metric| [metric.value, metric.created_at] }

      self.label = {
          x: label_x,
          y: label_y,
          title: ''
      }

      label[:title] = data.first.created_at.strftime('Since %a %D') if self.data.first
    end
  end
end
