class Report < ActiveRecord::Base
  audited on: [:destroy, :update]

  belongs_to :reportable, polymorphic: true
  belongs_to :user

  scope :users, -> { where reportable_type: 'User' }
  scope :reviews, -> { where reportable_type: 'Review' }

  validates_uniqueness_of :user_id, :scope => [:reportable_id, :reportable_type, :status]

  enum status: {
    unhandled: 0,
    rejected: 1,
    accepted: 2
  }

  def self.accept!
    all.find_each(&:accept!)
  end

  def self.reject!
    all.find_each(&:reject!)
  end

  def accept!
    self.status = 2
    save
  end

  def reject!
    self.status = 1
    save
  end

end
