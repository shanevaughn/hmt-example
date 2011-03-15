require 'spec_helper'

describe PhysiciansController do
  render_views

  describe "#new" do
    context "when authorized" do
      it "responds with the new page" do
        get :new
        response.should be_success
      end
      
      it "displays the new physician form" do
        get :new
        response.should have_selector('form', :class => "new_physician")
      end
    end
  end #new
  
  describe '#create' do
    context "when authorized" do
      before(:each) do
         @physician = Factory(:physician)
         @params = {:name => "Peter King"}
      end
      
      it 'creates a new physician' do
        lambda do 
          post :create, :physician => @params
        end.should change(Physician, :count).by(1)
      end

      it "redirects to the new physician's profile" do
        post :create, :physician => @params
        response.should redirect_to(physician_path(assigns(:physician)))
      end
      
      it 'displays the [created] flash message' do
        post :create, :physician => @params
        flash[:notice].should =~ /created/
      end
    end
  end #create
  
  
  describe "#index" do
    context "when authorized" do
      it "displays the physician index page" do
        get :index
        response.should be_success
      end
    end
  end #index
  
  
 describe "#show" do
   context "when authorized" do
     before(:each) do
       @physician = Physician.create!(:name => "Dr. Smith")
     end
     
     it "displays the physician show page" do
       get :show, :id => @physician
       response.should be_success
     end
     
     it "locates the correct physician" do
       get :show, :id => @physician
       assigns(:physician).should == @physician
     end
     
     it "displays the correct physician name" do
        get :show, :id => @physician
        response.should have_selector('body', :content => @physician.name)
      end
   end
 end
 
 describe "#edit" do
   context "when authorized" do
     before(:each) do
       @physician = Factory(:physician)
     end
     
     it "displays the physician index page" do
       get :edit, :id => @physician
       response.should be_success
     end
     
     it "displays the edit physician form" do
       get :edit, :id => @physician
       response.should have_selector('form', :class => "edit_physician")
     end
   end
 end #edit
 
 describe "#update" do
   context "when authorized" do
     before(:each) do 
        @physician = Factory(:physician)
        @params = { :name => 'Peter King'}
      end
      
      it "updates the physician attributes" do
        put :update, :id => @physician, :physician => @params 
        @physician.reload 
        @physician.name.should == @params[:name] 
      end
      
      it "displays the [updated] flash message" do
        put :update, :id => @physician, :physician => @params
        flash[:notice].should =~ /updated/
      end
   end
 end #update
 
 describe "#destroy" do
   context "when authorized" do
      before(:each) do
        @physician = Physician.create!(:name => "Dr. Smith")
      end
    
      it "should destroy the physician" do 
        lambda do
          delete :destroy, :id => @physician 
        end.should change(Physician, :count).by(-1)
      end
      
      it "redirects to physician_url" do
        delete :destroy, :id => @physician
        response.should redirect_to(physicians_url)
      end
      
      it "displays the [destroyed] flash message" do
        delete :destroy, :id => @physician
        flash[:notice].should =~ /removed/
      end
      
      it "removes associated record" do
        delete :destroy, :id => @physician
        @physician.appointments.should be_empty
      end
   end
 end #destroy
 
 describe "physician has appointments" do
    before(:each) do
      @physician = Factory(:physician)
      @appointments = @physicians.appointments.create!(:appt_dt => "2011/03/16", :appt_loc => "Medical Center 450")
    end
    
    it "has appointments" do
       @physician.appointments.should_not be_empty
    end
 end
  
end # controller

