// $(function () {
//   if (document.getElementById('container') !== null) {
//     gradesAjax('/stats', function(response) {
//       var gradePending = response.grades['N'] + response.grades[""]
//       console.log(gradePending)
//       $('#container').highcharts({
//         chart: {
//           plotBackgroundColor: null,
//       plotBorderWidth: 1,//null,
//       plotShadow: false,
//     },
//     title: {
//       text: 'Breakdown of Grades in New York City Restaurants'
//     },
//     credits: {
//       enabled: false
//     },
//     tooltip: {
//       pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
//     },
//     plotOptions: {
//       pie: {
//         allowPointSelect: true,
//         cursor: 'pointer',
//         dataLabels: {
//           enabled: true,
//           format: '<b>{point.name}</b>: {point.percentage:.1f} %',
//           style: {
//             color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
//           }
//         }
//       }
//     },
//     series: [{
//       type: 'pie',
//       name: 'Restaurant Grade Percentage',
//       data: [
//       ['A',   response.grades['A']],
//       ['B',       response.grades['B']],
//       ['C',    response.grades['C']],
//       ['Grade Pending', response.grades['Z']],
//       ['Not Yet Graded', gradePending]
//       ]
//     }]
//   });


//     $('#container2').highcharts({
//       chart: {
//         type: 'column'
//       },
//       title: {
//         text: 'Commonly Issued Violations in 2014'
//       },
//       xAxis: {
//         type: 'category',
//         labels: {
//           rotation: -45,
//           style: {
//             fontSize: '8px',
//             fontFamily: 'Verdana, sans-serif'
//           }
//         }
//       },
//       yAxis: {
//         min: 0,
//         title: {
//           text: 'Violations since 01/01/2014'
//         }
//       },
//       credits: {
//         enabled: false,
//       },
//       legend: {
//         enabled: false
//       },
//       tooltip: {
//         pointFormat: 'Total Violations Issued in 2014: <b>{point.y} </b>'
//       },
//       series: [{
//         name: 'Inspections: ',
//         data: [
//         ['Thawing Procedures improper.', response.inspections['09C']],
//         ['Hot food not held at or above 140°F', response.inspections['02B']],
//         ['Food protection certificate not held by supervisor.', response.inspections['04A']],
//         ['Tobacco use, eating, drinking in food prep area.', response.inspections['06B']],
//         ['Cold food held above 41°F', response.inspections['02G']],
//         ['Food in contact with utensil, container, or pipe that consists of toxic material.', response.inspections['02H']],
//         ['Food not protected from potential source of contamination.', response.inspections['06C']],
//         ['Unprotected food re-served.', response.inspections['04J']],
//         ['Evidence of rats or live rats found.', response.inspections['04L']],
//         ['Evidence of mice or live mice found.', response.inspections['04M']],
//         ['Evidence of roaches or live roaches found.', response.inspections['04N']]
//         ['Facility not vermin proof.', response.inspections['08A']],
//         ['Personal cleanliness inadequate.', response.inspections['06A']],
//         ['Hand washing facility not provided in food prep area.', response.inspections['05D']],

//         ],
//         dataLabels: {
//           enabled: false,
//           rotation: -90,
//           color: '#FFFFFF',
//           align: 'right',
//           x: 4,
//           y: 10,
//           style: {
//             fontSize: '13px',
//             fontFamily: 'Verdana, sans-serif',
//             textShadow: '0 0 3px black'
//           }
//         }
//       }]
//     });

// });

//  }
// });

