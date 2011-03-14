class PatientsController < ApplicationController
  respond_to :html
  
  def index
    @patients = Patient.all
  end

  def show
    @patient = Patient.find(params[:id])
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(params[:patient])
        
    if @patient.save
      redirect_to @patient, :notice => "Successfully created Patient."
    else
      render :action => 'new'
    end
  end

  def edit
    @patient = Patient.find(params[:id])
  end

  def update
    @patient = Patient.find(params[:id])
    if @patient.update_attributes(params[:patient])
      redirect_to @patient, :notice  => "Successfully updated Patient."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy
    redirect_to patients_url, :notice => "Successfully removed Patient."
  end
end

