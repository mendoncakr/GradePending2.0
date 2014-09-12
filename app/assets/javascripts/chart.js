function gradesAjax (callback) { 
  $.get('/stats')
  .done(function (response) {
    callback(response)
  })
};

$(function () {
  if (document.getElementById('container') !== null) {
    gradesAjax(function(response) {
      console.log(response)
      $('#container').highcharts({
        chart: {
          plotBackgroundColor: null,
      plotBorderWidth: 1,//null,
      plotShadow: false,
    },
    title: {
      text: 'Breakdown of Grades in New York City Restaurants'
    },
    credits: {
      enabled: false
    },
    tooltip: {
      pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
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
      name: 'Restaurant Grade Percentage',
      data: [
      ['A',   response.a],
      ['B',       response.b],
      ['C',    response.c],
      ['Grade Pending', response.gp],
      ['Not Yet Graded', response.no_grade]
      ]
    }]
  });


    $('#container2').highcharts({
      chart: {
        type: 'column'
      },
      title: {
        text: 'Most common violations in 2014'
      },
      xAxis: {
        type: 'category',
        labels: {
          rotation: -45,
          style: {
            fontSize: '13px',
            fontFamily: 'Verdana, sans-serif'
          }
        }
      },
      yAxis: {
        min: 0,
        title: {
          text: 'Population (millions)'
        }
      },
      legend: {
        enabled: false
      },
      tooltip: {
        pointFormat: 'Population in 2008: <b>{point.y:.1f} millions</b>'
      },
      series: [{
        name: 'Inspections: ',
        data: [
        ['Thawing Procedures improper.', response.inspections['09C']],
        ['Tobacco use, eating, drinking in food prep area.', response.inspections['06B']]

        ],
        dataLabels: {
          enabled: true,
          rotation: -90,
          color: '#FFFFFF',
          align: 'right',
          x: 4,
          y: 10,
          style: {
            fontSize: '13px',
            fontFamily: 'Verdana, sans-serif',
            textShadow: '0 0 3px black'
          }
        }
      }]
    });
 
});

 }
});

