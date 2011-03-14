class Patient < ActiveRecord::Base
  
  attr_accessible :name, :appointments_attributes
  
  has_many :appointments, :dependent => :destroy
  has_many :physicians, :through => :appointments
  
  accepts_nested_attributes_for :appointments, :allow_destroy => true
  
end
