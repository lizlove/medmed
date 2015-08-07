class ScheduledDosesController < ApplicationController
   before_action :set_dose, only: [:update]

   def index
      @patient = Patient.find(params[:patient_id])
   end 

   def update
   @patient = Prescription.find(dose_params[:prescription_id]).patient

    respond_to do |format|
      if @scheduled_dose.update(dose_params)
        format.html { redirect_to patient_scheduled_doses_path(@patient) }
        format.js
      end
    end

   end 

end

private
   def set_dose
     @scheduled_dose = ScheduledDose.find(params[:id])
   end

   def dose_params
      params.require(:scheduled_dose).permit(:prescription_id, :scheduled_time, :taken_time, :side_effect, :was_taken)
    end