highCharts = {
  similarlyGraded : function(data) {
   $('#similargrade').highcharts({
    chart: {
      type: 'funnel',
      marginRight: 100
    },
    title: {
      text: 'How '+data.name+' compares to other '+data.code+' restaurants' ,
      x: -20
    },
    plotOptions: {
      series: {
        dataLabels: {
          enabled: true,
          format: '<b>{point.name}</b> ({point.y:,.0f})',
          color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
        },
        neckWidth: '0%',
        neckHeight: '0%',
        width: '100%'
      }
    },
    legend: {
      enabled: false
    },
    series: [{
      name: '# of Restaurants',
      data: [
      ['Grade: A', data.grades["A"]],
      ['Grade: B', data.grades["B"]],
      ['Grade: C', data.grades["C"] || 0],
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