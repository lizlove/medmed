$(document).ready(function(){
  $('select.recurrence_option').on('change', function(){
    if ("Daily" == $(this).val()){
      $(".field_to_switch :nth-child(3)").text("days")
      $(".weekdays").hide()
    } else if ("Hourly" == $(this).val()){
      $(".field_to_switch :nth-child(3)").text("hours")
      $(".weekdays").hide()
    } else if("Weekly" == $(this).val()){
      $(".field_to_switch :nth-child(3)").text("weeks")
      $(".weekdays").show()
    }
  })
})