class Metric < ActiveRecord::Base
  NAMES = %w{coverage-models coverage-controllers coverage-all-files coverage-mailers coverage-helpers coverage-libraries coverage-plugins coverage-ungrouped}

  belongs_to :project

  validates :project, presence: true

  validates :timestamp, presence: true

  validates :name, inclusion: Metric::NAMES
end
