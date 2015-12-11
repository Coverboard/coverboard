module MetricPresenter
  class Gauge
    attr_accessor :name, :value, :diff, :positive

    def initialize(project, metric_name, title)
      self.name = title
      self.value = 0
      self.positive = true
      self.diff = 0

      current, previous = project.metrics.named(metric_name).for_gauges
      return unless current

      self.value = current.value

      return unless previous

      self.diff = previous.value - current.value
      self.positive = self.diff >= 0
    end
  end
end
