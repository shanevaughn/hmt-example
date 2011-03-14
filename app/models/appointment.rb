class Appointment < ActiveRecord::Base
  
  attr_accessible :physician_id, :patient_id, :appt_dt, :appt_loc
  
  belongs_to :patient
  belongs_to :physician
  
end
