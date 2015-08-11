class PrescriptionsController < ApplicationController
  before_action :set_prescription, only: [:show, :destroy]
  
  def show
  end

  def index
  end

  def new
    @prescription = Prescription.new
    @medication = Medication.new
  end

  def create
    @prescription = Prescription.new(prescription_params)
    add_to_doctor_and_patient
    set_create_params
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

  def medication_search
    keyword = params[:keyword]
    @medication_list = Medication.dropdown_hash(keyword).to_a
    respond_to { |format| format.js }
  end

  def destroy
    @scheduled_doses = @prescription.scheduled_doses
    @scheduled_doses.each { |dose| dose.destroy }
    @prescription.destroy
    redirect_to doctor_patients_path
  end

  private

  def set_create_params
    @prescription.medication_name = Medication.find_name_by_rxcui(params[:rxcui]) if params[:rxcui]
    @prescription.rxcui = params[:rxcui]
    @prescription.add_recurrence_rule(params[:interval], params[:occurrence], params[:days])
  end

  def add_to_doctor_and_patient
    current_doctor.prescriptions << @prescription
    patient = Patient.find(params[:prescription][:patient_id])
    patient.prescriptions << @prescription
  end

  def set_prescription
    @prescription = Prescription.find(params[:id])
  end

  def prescription_params
    params.require(:prescription).permit(:start_datetime, :end_datetime, :medication_name, :image_url, :doctor_id, :rxcui)
  end
end
