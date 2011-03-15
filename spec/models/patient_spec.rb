require 'spec_helper'

describe Patient do
  describe "validation" do
    
    it "requires presence of patient name" do
      patient = Factory.build(:patient, :name => nil)
      patient.should_not be_valid
    end
  
    it "requires many appointments" do
      Patient.new.appointments.should == []
    end
    
    it "requires many patients" do
      Patient.new.physicians.should == []
    end
  end
end

