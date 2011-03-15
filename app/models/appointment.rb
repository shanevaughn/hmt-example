# == Schema Information
# Schema version: 20110314170340
#
# Table name: appointments
#
#  id           :integer         not null, primary key
#  physician_id :integer
#  patient_id   :integer
#  appt_loc     :string(255)
#  appt_dt      :date
#  created_at   :datetime
#  updated_at   :datetime
#

class Appointment < ActiveRecord::Base
  attr_accessible :physician_id, :patient_id, :appt_dt, :appt_loc
  
  belongs_to :patient
  belongs_to :physician
  
  validates_presence_of :appt_dt, :appt_loc
end
