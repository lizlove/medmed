$(function(){
    //get Patient labels
    // $("#barlabel").on('mousedown', function(){
           var $patients = $("#barlabel").text().split(", ");
           var $data = $("#bardata").text().split(", "); 

        var data = {
            labels: $patients,
            datasets: [
        {
            label: "Current Patient Total Compliance",
            fillColor: "rgba(220,220,220,0.5)",
            strokeColor: "rgba(220,220,220,0.8)",
            highlightFill: "rgba(220,220,220,0.75)",
            highlightStroke: "rgba(220,220,220,1)",
            data: $data
            }
        ]
    };

    var barChart = new Chart($("#barchart").get(0).getContext("2d")).Bar(data)

    // }); //onMouseDown

});// BarChart
