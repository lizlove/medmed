class ScheduledDosesController < ApplicationController
   before_action :set_dose, only: [:update]

   def index
      @patient = Patient.find(params[:patient_id])
   end 

   def update
   @patient = Prescription.find(dose_params[:prescription_id]).patient

    respond_to do |format|
      if @dose.update(dose_params)
        format.html { redirect_to patient_scheduled_doses_path(@patient) }
        # self.taken_time = Time.now
        # self.was_taken = true
      end
    end

   end 

end

private
   def set_dose
      @dose = ScheduledDose.find(params[:id])
   end

   def dose_params
      params.require(:scheduled_dose).permit(:prescription_id, :scheduled_time, :taken_time, :side_effect, :was_taken)
    end