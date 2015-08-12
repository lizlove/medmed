class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update]

  def index
    @doctor = current_doctor
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.find(params[:patient][:id])
    @doctor = current_doctor
    @doctor.patients << @patient
    redirect_to doctor_patients_path
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if (params[:id] != "0") && (params[:id] != "")
      @patient = Patient.find(params[:id])
      current_doctor.patients.destroy(@patient)
      redirect_to doctor_patients_path
    else
      redirect_to doctor_patients_drop_path
    end
  end

  def drop
    @patient = Patient.new
    @doctor = current_doctor
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone_number, :time_zone)
  end
end

