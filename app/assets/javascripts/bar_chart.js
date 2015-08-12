$(function(){
    //get Patient labels, get data for each patient from hidden field
           var $patients = $("#barlabel").text().trim().split(",");
           var $datas = $("#bardata").text().trim().split(","); 

        var data = {
            labels: $patients,
            datasets: [
        {
            label: "Current Patient Total Compliance",
            fillColor: "rgba(23,123,187,0.75)",
            strokeColor: "rgba(220,220,220,0.8)",
            highlightFill: "rgba(175,210,240,0.5)",
            highlightStroke: "rgba(220,220,220,1)",
            data: $datas
            }
        ]
    };

    var barChart = new Chart($("#barchart").get(0).getContext("2d")).Bar(data)

});// BarChart
