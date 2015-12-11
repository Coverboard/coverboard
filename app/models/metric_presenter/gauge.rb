module MetricPresenter
  class Gauge
    attr_accessor :name, :value, :diff, :positive

    def initialize(project, metric_name, title)
      self.name = title
      self.value = 0
      self.positive = true
      self.diff = 0

      previous, current = project.metrics.named(metric_name).for_gauges

      if !current && previous
        self.value = previous.value
        return
      end

      self.value = current.value

      return unless previous

      self.diff = current.value - previous.value
      self.positive = self.diff >= 0
    end
  end
end
