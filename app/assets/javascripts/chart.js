function gradesAjax (callback) { 
  $.get('/stats')
  .done(function (response) {
    callback(response)
  })
}
$(function () {
  if (document.getElementById('container') !== null) {
    gradesAjax(function(response) {
      $('#container').highcharts({
        chart: {
          plotBackgroundColor: null,
          plotBorderWidth: 1,//null,
          plotShadow: false
        },
        title: {
          text: 'Breakdown of Grades in New York City Restaurants'
        },
        tooltip: {
          pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        credits: {
          enabled: false
        },
        plotOptions: {
          pie: {
            allowPointSelect: true,
            cursor: 'pointer',
            dataLabels: {
              enabled: true,
              format: '<b>{point.name}</b>: {point.percentage:.1f} %',
              style: {
                color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
              }
            }
          }
        },
        series: [{
          type: 'pie',
          name: 'Restaurant Inspection Grade',
          data: [
          ['A',   response.a],
          ['B',       response.b],
          ['C',    response.c],
          ]
        }]
      });

    })
  }
}); 