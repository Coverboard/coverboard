class Metric < ActiveRecord::Base
  NAMES = %w{coverage-models coverage-controllers coverage-all-files coverage-mailers coverage-helpers coverage-libraries coverage-plugins coverage-ungrouped}

  belongs_to :project

  validates :project, presence: true

  validates :timestamp, presence: true

  validates :name, inclusion: Metric::NAMES

  scope :for_trends, -> { order(timestamp: :desc).limit(60) }
  scope :for_gauges, -> { order(timestamp: :desc).limit(2) }

  def self.named(name)
    where(name: name)
  end
end
