class Exchange < ActiveRecord::Base

  has_one :listing
  has_and_belongs_to_many :users

  validates_presence_of :amount, :destination,
                        :source, :description

  validates_inclusion_of :status, in: %w{ pending paid failed }

  before_validation :verify_balance

  after_create :transfer_funds

  def self.transfer(source,dest,amount)
    self.create(
      amount: amount,
      destination: dest.id,
      source: source.id,
      description: "transfer #{amount} points from #{source.name} to #{dest.name}"
    )
  end

  private

  def transfer_funds
    if self.status == "paid"
      User.find(self.source).subtract_points(self.amount)
      User.find(self.destination).add_points(self.amount)
    end
  end

  def verify_balance
    source_user = User.find(source)
    self.status = "pending"

    if source_user.points >= amount
      self.status = "paid"
    elsif  source_user.points < amount
      self.status = "failed"
    end
  end
end
