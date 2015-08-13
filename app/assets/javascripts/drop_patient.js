$(function(){
  $('#patient_id').on("change", function(){
    var pat_id = $('#patient_id').val();
    $('form#delete_patient').attr("action", "/doctors/3/patients/"+pat_id);
  });
});


//$('form#delete_patient').click(function(e){
//    e.preventDefault();
//
//    var url = $(this).attr('action');
//    var method
//
//
//    $.ajax({
//        url: url,
//
//    })
//})