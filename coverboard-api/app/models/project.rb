class Project < ActiveRecord::Base
  has_many :metrics

  validates :uid, uniqueness: true
  validates :name, presence: true

  before_create :generate_uid

  private
    def generate_uid
      self.uid = SecureRandom.hex if self.uid.nil?
    end
end
