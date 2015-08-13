$(function(){
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
  if ($("#barchart").get(0)){
    var ctx = $("#barchart").get(0).getContext("2d");
    var barChart = new Chart(ctx).Bar(data)
  };
});// BarChart

$("#patient_select").change(function(event) {
  debugger;
  barChart.update();
});