highCharts = {
  similarlyGraded : function(data){
    $('#similargrade').highcharts({
      chart: {
        type: 'pyramid',
        marginRight: 100
      },
      title: {
        text: 'Restaurants with similar cuisine',
        x: 0
      },
      plotOptions: {
        series: {
          dataLabels: {
            enabled: true,
            format: '<b>{point.name}</b> ({point.y:,.0f})',
            color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black',
            softConnector: true
          }
        }
      },
      legend: {
        enabled: false
      },
      series: [{
        name: 'Unique users',
        data: [
        ['A', data.grades["A"]],
        ['B', data.grades["B"]],
        ['C', data.grades["C"]],
        ['Grade Pending', data.grades["Z"]],
        ['Not Yet Graded', data.grades["No Grade"]]
        ]
      }],
      exporting: {
        enabled: false
      },
      credits: {
        enabled: false
      },
    });
  }
}
