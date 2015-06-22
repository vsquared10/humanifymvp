class Exchange < ActiveRecord::Base

  has_one :listing
  has_and_belongs_to_many :users

  validates_presence_of :amount, :destination,
                        :source, :description

  validates_inclusion_of :status, in: %w{ pending paid failed }

  before_validation :check_balance


  private

  def transfer(source,destination,amount)
    source.subtract_points(amount)
    destination.add_points(amount)
  end

  def check_balance
    source_user = User.find(source)
    self.status = "pending"

    if source_user.points > amount
      self.status = "paid"
      transfer(source_user, User.find(destination), amount)
    elsif  source_user.points < amount
      self.status = "failed"
    end
  end
end
