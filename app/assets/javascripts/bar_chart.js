$(function(){
    //get Patient labels
    // $("#barlabel").on('mousedown', function(){
           var $patient = $("#barlabel").text().split(", "); 

        var data = {
            labels: $patient,
            datasets: [
        {
            label: "Current Patient Total Compliance",
            fillColor: "rgba(220,220,220,0.5)",
            strokeColor: "rgba(220,220,220,0.8)",
            highlightFill: "rgba(220,220,220,0.75)",
            highlightStroke: "rgba(220,220,220,1)",
            data: [65, 59, 80, 81]
            }
        ]
    };

    var barChart = new Chart($("#barchart").get(0).getContext("2d")).Bar(data)

    // }); //onMouseDown

});// BarChart
