$(function(){
var data = {
    labels: <%= DoctorDash.patients_per_doctor(@doctor) %>,
    datasets: [
        {
            label: "My First dataset",
            fillColor: "rgba(220,220,220,0.5)",
            strokeColor: "rgba(220,220,220,0.8)",
            highlightFill: "rgba(220,220,220,0.75)",
            highlightStroke: "rgba(220,220,220,1)",
            data: [65, 59, 80, 81]
        }
    ]
};

patientsBarChart = new Chart($("#barchart").get(0).getContext("2d")).Line(data)

};// BarChart