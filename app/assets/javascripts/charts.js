highCharts = {
  totalGrades : function(response, grade) {
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
          ['A',   response.grades['A']],
          ['B',       response.grades['B']],
          ['C',    response.grades['C']],
          ['Grade Pending', response.grades['Z']],
          ['Not Yet Graded', grade]]
      }]
    });
  },

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
 },
 commonViolations : function (response) {
  $('#container2').highcharts({
        chart: {
          type: 'column'
        },
        title: {
          text: 'Commonly Issued Violations in 2014'
        },
        xAxis: {
          type: 'category',
          labels: {
            rotation: -45,
            style: {
              fontSize: '8px',
              fontFamily: 'Verdana, sans-serif'
            }
          }
        },
        yAxis: {
          min: 0,
          title: {
            text: 'Violations since 01/01/2014'
          }
        },
        credits: {
          enabled: false,
        },
        legend: {
          enabled: false
        },
        tooltip: {
          pointFormat: 'Total Violations Issued in 2014: <b>{point.y} </b>'
        },
        series: [{
          name: 'Inspections: ',
          data: [
          ['Thawing Procedures improper.', response.inspections['09C']],
          ['Hot food not held at or above 140°F', response.inspections['02B']],
          ['Food protection certificate not held by supervisor.', response.inspections['04A']],
          ['Tobacco use, eating, drinking in food prep area.', response.inspections['06B']],
          ['Cold food held above 41°F', response.inspections['02G']],
          ['Food in contact with utensil, container, or pipe that consists of toxic material.', response.inspections['02H']],
          ['Food not protected from potential source of contamination.', response.inspections['06C']],
          ['Unprotected food re-served.', response.inspections['04J']],
          ['Evidence of rats or live rats found.', response.inspections['04L']],
          ['Evidence of mice or live mice found.', response.inspections['04M']],
          ['Evidence of roaches or live roaches found.', response.inspections['04N']]
          ['Facility not vermin proof.', response.inspections['08A']],
          ['Personal cleanliness inadequate.', response.inspections['06A']],
          ['Hand washing facility not provided in food prep area.', response.inspections['05D']],

          ],
          dataLabels: {
            enabled: false,
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
 }
}
