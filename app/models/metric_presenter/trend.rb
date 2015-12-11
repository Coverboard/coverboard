module MetricPresenter
  class Trend
    attr_accessor :data, :label

    def initialize(project, metric_name, label_x, label_y)
      self.data = project.metrics.named(metric_name).for_trends.map { |metric| metric.value }
      self.label = {
          x: label_x,
          y: label_y
      }
    end
  end
end
