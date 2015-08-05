class PrescriptionsController < ApplicationController
  # before_action :set_prescription, only: [:edit, :update, :destroy]
  def index 
  end 

  def new
    @prescription = Prescription.new
  end

  def create
    @prescription = Prescription.new(prescription_params)
    respond_to do |format|
      if @prescription.save
        current_doctor.prescriptions << @prescription
        patient = Patient.find(1)
        patient.prescriptions << @prescription
        format.html { redirect_to doctors_dashboard_path, notice: 'Prescription was successfully created.' }
        format.json { render action: 'show', status: :created, location: @prescription }
      else
        format.html { render action: 'new' }
        format.json { render json: @prescription.errors, status: :unprocessable_entity }
      end
    end
  end

  # def edit
  # end

  # def update
  #   respond_to do |format|
  #     if @prescription.update(prescription_params)
  #       format.html { redirect_to @prescription, notice: 'Prescription was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @prescription.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # def destroy
  #   @prescription.destroy
  #   respond_to do |format|
  #     format.html { redirect_to prescriptions_url }
  #     format.json { head :no_content }
  #   end
  # end

  private

  def set_prescription
    @prescription = Prescription.find(params[:id])
  end
# do we need to have password_confirmation here?
  def prescription_params
    params.require(:prescription).permit(:rxcui, :recurrence, :start_datetime, :end_datetime, :side_effects, :image_url, :medication_name)
  end

end
