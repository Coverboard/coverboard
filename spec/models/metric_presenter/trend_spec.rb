require 'rails_helper'

describe MetricPresenter::Trend do
  context 'no metrics' do
    let(:project) { Project.new }
    subject { MetricPresenter::Trend.new project, 'coverage', 'label x', 'label y' }

    it { expect(subject.data).to eq([]) }
    it { expect(subject.label[:x]).to eq('label x') }
    it { expect(subject.label[:y]).to eq('label y') }
    it { expect(subject.label[:title]).to eq('') }
  end
end
