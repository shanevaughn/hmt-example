class AppointmentsController < ApplicationController
  respond_to :html

  def new
    # how should this be written to handle both patients and physicians?
    @appointment = patient.appointments.new

    respond_with [patient, @appointment]
  end

  def create
    @appointment = patient.appointments.new(params[:appointment])

    respond_with [patient, @appointment] do |format|
      format.html {
        if @appointment.save
          flash[:notice] = 'The appointment was created.'
          redirect_to(patient_path(patient))
        else
          render "new"
        end
      }
    end
  end
  
  def edit
    @appointment = patient.appointments.find(params[:id])
    respond_with [patient, @appointment]
  end
  
  def update
    @appointment = patient.appointments.find(params[:id])

    update_was_successful = @appointment.update_attributes(params[:appointment])

    respond_with [patient, @appointment] do |format|
      format.html {
        if update_was_successful
          redirect_to(patient_path(patient), :notice => 'The appointment was saved')
        else
          render "edit"
        end
      }
    end
  end

  def destroy
    appointment = patient.appointment.find(params[:id])
    if appointment.destroy
      flash[:notice] = 'The appointment was destroyed.'
    else
      flash[:alert] = 'The appointment could not be destroyed'
    end

    respond_with [patient, @appointment] do |format|
      format.html { redirect_to(patient_path(patient)) }
    end
  end
  

  private

  def patient
    @patient ||= Patient.find(params[:patient_id])
  end

end
