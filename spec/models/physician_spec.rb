require 'spec_helper'

describe Physician do
  describe "validation" do
    
    it "requires presence of physician name" do
      physician = Factory.build(:physician, :name => nil)
      physician.should_not be_valid
    end
  
    it "requires many appointments" do
      Physician.new.appointments.should == []
    end
    
    it "requires many patients" do
      Physician.new.patients.should == []
    end
  end
end
