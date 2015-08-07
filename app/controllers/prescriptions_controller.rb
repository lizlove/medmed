class PrescriptionsController < ApplicationController
  # before_action :set_prescription, only: [:edit, :update, :destroy]
  
  def show
    @prescription = Prescription.find(params[:id])
  end 

  def index 

  end 

  def new
    @prescription = Prescription.new
    @medication = Medication.new
  end

  def create
    @prescription = Prescription.new(prescription_params)
    @prescription.medication_name = Medication.find_name_by_rxcui(params[:rxcui]) if params[:rxcui]
    @prescription.rxcui = params[:rxcui]
    current_doctor.prescriptions << @prescription
    patient = Patient.find(params[:prescription][:patient_id])
    patient.prescriptions << @prescription
    if params[:days]
      @prescription.add_recurrence_rule(params[:interval], params[:occurrence], params[:days])
    else
      @prescription.add_recurrence_rule(params[:interval], params[:occurrence])
    end
    respond_to do |format|
      if @prescription.save
        format.html { redirect_to doctor_patients_path, notice: 'Prescription was successfully created.' }
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

  def medication_search
    keyword = params[:keyword]

    @medication_list = Medication.dropdown_hash(keyword).to_a

    respond_to do |format|
      format.js
    end

  end

  def destroy
    @prescription = Prescription.find(params[:id])
    @scheduled_doses = @prescription.scheduled_doses
    @scheduled_doses.each do |dose|
      dose.destroy
    end
    @prescription.destroy
    redirect_to doctor_patients_path
  end

  private

  def set_prescription
    @prescription = Prescription.find(params[:id])
  end
# do we need to have password_confirmation here?
  def prescription_params
    params.require(:prescription).permit(:start_datetime, :end_datetime, :medication_name, :image_url, :doctor_id, :rxcui)
  end

end
