class Metric < ActiveRecord::Base
  NAMES = %w{coverage coverage-models coverage-controllers}

  belongs_to :project

  validates :project, presence: true

  validates :name, inclusion: Metric::NAMES
end
