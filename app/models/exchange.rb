class Exchange < ActiveRecord::Base

  has_one :listing
  has_and_belongs_to_many :users

  validates_presence_of :amount, :destination,
                        :source, :description

  validates_inclusion_of :status, in: %w{ pending paid failed }

  validate :exchange_valid

  private

  def exchange_valid
    binding.pry()
  end
end
