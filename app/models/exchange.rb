class Exchange < ActiveRecord::Base

  validates_presence_of :object_type, :amount,
                        :destination, :source,
                        :description

  validates_inclusion_of :status, in: %w{ pending paid failed }
end
