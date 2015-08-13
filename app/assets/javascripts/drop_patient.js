$(function(){
  $('#patient_id').on("change", function(){
    var pat_id = $('#patient_id').val();
    $('form#new_patient').attr("action", "/doctors/3/patients/"+pat_id);
  });
});