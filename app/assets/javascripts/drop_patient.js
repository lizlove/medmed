$(function(){
  $('#patient_id').on("change", function(){
    var pat_id = $('#patient_id').val();
      var doctor_id = $('form#delete_patient').data('doctor-id');

      $('form#delete_patient').attr("action", "/doctors/" + doctor_id + "/patients/"+ pat_id);
  });
});

