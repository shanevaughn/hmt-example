Factory.define :physician do |physician|
  physician.name  "Dr. Smith"
end

Factory.define :patient do |patient|
  patient.name  "John Doe"
end

Factory.define :appointment do |appointment|
  appointment.patient     { |c| c.association(:patient) }
  appointment.physician   { |c| c.association(:physician) }
  appointment.appt_dt   "2011/03/15"
  appointment.appt_loc  "Med Center, Office 235"
end