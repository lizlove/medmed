
$(function(){
    $('.scheduled_doses').on('click', '#scheduled_dose_was_taken', function(){
        $(this).parent('form').submit();
    })
})

