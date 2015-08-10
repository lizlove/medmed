$(function() {
    $("#localtime").click(function() {
       if ($(this).checked)){ 
          $("#time_zoner").attr("disabled", "disabled");
       } else {
          $("#time_zoner").removeAttr("disabled");  
       }
    });
});

