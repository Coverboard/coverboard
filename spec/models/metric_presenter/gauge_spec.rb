require 'rails_helper'

describe MetricPresenter::Gauge do
  context 'no metrics in the database' do
    let(:project) { Project.new }
    subject { MetricPresenter::Gauge.new project, 'metric_name', 'title' }

    it { expect(subject.name).to eq('title') }
    it { expect(subject.value).to eq(0) }
    it { expect(subject.positive).to eq(true) }
    it { expect(subject.diff).to eq(0) }
  end

  context 'one metric' do
    let(:project) do
      project = Project.create! name: 'test'
      Metric.create!({ name: 'coverage', timestamp: 1, value: 25, project: project })
      project
    end

    subject { MetricPresenter::Gauge.new project, 'coverage', 'title' }
    it { expect(subject.value).to eq(25) }
    it { expect(subject.positive).to eq(true) }
    it { expect(subject.diff).to eq(0) }
  end

  context 'two metrics' do
    let(:project) do
      project = Project.create! name: 'test'
      Metric.create!({ name: 'coverage', timestamp: 10, value: 50, project: project })
      Metric.create!({ name: 'coverage', timestamp: 20, value: 40, project: project })
      project
    end

    subject { MetricPresenter::Gauge.new project, 'coverage', 'title' }
    it { expect(subject.value).to eq(40) }
    it { expect(subject.positive).to eq(false) }
    it { expect(subject.diff).to eq(-10) }
  end
end
