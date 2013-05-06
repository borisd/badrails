class Order < ActiveRecord::Base
  attr_accessible :description, :amount

  has_many :charges
  
  validates_presence_of :amount

  def charge!
    c = Charge.new
    c.order = self
    c.save!
  end
end

