# == Schema Information
# Schema version: 20110314170340
#
# Table name: physicians
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Physician < ActiveRecord::Base
  attr_accessible :name, :appointments_attributes
  
  has_many :appointments, :dependent => :destroy
  has_many :patients, :through => :appointments
  
  validates_presence_of :name
  
  accepts_nested_attributes_for :appointments, :allow_destroy => true
end
