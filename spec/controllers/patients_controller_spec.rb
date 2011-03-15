require 'spec_helper'

describe PatientsController do
  render_views

  describe "#new" do
    context "when authorized" do
      it "responds with the new page" do
        get :new
        response.should be_success
      end
      
      it "displays the new patient form" do
        get :new
        response.should have_selector('form', :class => "new_patient")
      end
    end
  end #new
  
  describe '#create' do
    context "when authorized" do
      before(:each) do
         @patient = Factory(:patient)
         @params = {:name => "Peter King"}
      end
      
      it 'creates a new patient' do
        lambda do 
          post :create, :patient => @params
        end.should change(Patient, :count).by(1)
      end

      it "redirects to the new patient's profile" do
        post :create, :patient => @params
        response.should redirect_to(patient_path(assigns(:patient)))
      end
      
      it 'displays the [created] flash message' do
        post :create, :patient => @params
        flash[:notice].should =~ /created/
      end
    end
  end #create
  
  
  describe "#index" do
    context "when authorized" do
      it "displays the patient index page" do
        get :index
        response.should be_success
      end
    end
  end #index
  
  
 describe "#show" do
   context "when authorized" do
     before(:each) do
       @patient = Patient.create!(:name => "Peter King")
     end
     
     it "displays the patient show page" do
       get :show, :id => @patient
       response.should be_success
     end
     
     it "locates the correct patient" do
       get :show, :id => @patient
       assigns(:patient).should == @patient
     end
     
     it "displays the correct patient name" do
        get :show, :id => @patient
        response.should have_selector('body', :content => @patient.name)
      end
   end
 end
 
 describe "#edit" do
   context "when authorized" do
     before(:each) do
       @patient = Factory(:patient)
     end
     
     it "displays the patient index page" do
       get :edit, :id => @patient
       response.should be_success
     end
     
     it "displays the edit patient form" do
       get :edit, :id => @patient
       response.should have_selector('form', :class => "edit_patient")
     end
   end
 end #edit
 
 describe "#update" do
   context "when authorized" do
     before(:each) do 
        @patient = Factory(:patient)
        @params = { :name => 'Peter King'}
      end
      
      it "updates the patient attributes" do
        put :update, :id => @patient, :patient => @params 
        @patient.reload 
        @patient.name.should == @params[:name] 
      end
      
      it "displays the [updated] flash message" do
        put :update, :id => @patient, :patient => @params
        flash[:notice].should =~ /updated/
      end
   end
 end #update
 
 describe "#destroy" do
   context "when authorized" do
      before(:each) do
        @patient = Patient.create!(:name => "Peter King")
      end
    
      it "should destroy the patient" do 
        lambda do
          delete :destroy, :id => @patient 
        end.should change(Patient, :count).by(-1)
      end
      
      it "redirects to patient_url" do
        delete :destroy, :id => @patient
        response.should redirect_to(patients_url)
      end
      
      it "displays the [destroyed] flash message" do
        delete :destroy, :id => @patient
        flash[:notice].should =~ /removed/
      end
      
      it "removes associated record" do
        delete :destroy, :id => @patient
        @patient.appointments.should be_empty
      end
   end
 end #destroy
 
 describe "Patient has appointments" do
    before(:each) do
      @patient = Factory(:patient)
      @appointments = @patients.appointments.create!(:appt_dt => "2011/03/16", :appt_loc => "Medical Center 450")
    end
    
    it "has appointments" do
       @patient.appointments.should_not be_empty
    end
 end
  
end # controller

