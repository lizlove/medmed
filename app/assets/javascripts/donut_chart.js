$(function(){
  var $missed = $("#missed").text().trim();
  var $taken =  $("#taken").text().trim();
  var data = [
    {
      value: $missed,
      color:"#F7464A",
      highlight: "#FF5A5E",
      label: "Missed"
    },
    {
      value: $taken,
      color: "#46BFBD",
      highlight: "#5AD3D1",
      label: "Taken"
    }
  ]
  if ($("#donut").get(0)) {
    var ctx = $("#donut").get(0).getContext("2d");
    var totalDonut = new Chart(ctx).Doughnut(data,{ animateScale: true });
  };
});

