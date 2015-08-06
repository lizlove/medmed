
$(function(){
    $('.scheduled_doses').on('click', '#scheduled_dose_was_taken', function(){
        $(this).parent('form').submit();
    })
})


function ScheduledDose(id) {
    this.id = id;
}

ScheduledDose.prototype.update = function(html, sdClass){
    $('#sd-' + this.id).find('.text-success').html(html);
    $('#sd-' + this.id).attr('class', sdClass);
}





