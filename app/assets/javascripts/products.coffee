# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

makeAxis = (color, endValue, radius, innerRadius, balloonText) ->
  [
    color: '#eee'
    startValue: 0,
    endValue: 100,
    radius: radius,
    innerRadius: innerRadius
  ,
    color: color
    startValue: 0
    endValue: endValue
    radius: radius + '%'
    innerRadius: innerRadius + '%'
    balloonText: balloonText + '%'
  ]

makeLabel = (name, y, color) ->
  text: name
  x: 49 + '%'
  y:  y + '%'
  size: 15
  bold: true
  color: color
  align: 'right'

makeGraphs = (title, series) ->
  title: title
  balloonText: "[[category]]: [[value]] m/s"
  bullet: 'round'
  lineAlpha: 0
  series: series

gaugeChart = () ->
  type: "gauge"
  theme: "light"
  axes: [
    axisAlpha: 0
    tickAlpha: 0
    labelsEnabled: false
    startValue: 0
    endValue: 100
    startAngle: 0
    endAngle: 270
    bands: [
      makeAxis '#84b761', 100, 100,  85,  90
      makeAxis '#fdd400',  35,  80,  65,  35
      makeAxis '#cc4748',  92,  60,  45,  92
      makeAxis '#67b7dc',  68,  40,  25,  68
    ].reduce (i,a) -> i.concat a
  ]

  allLabels: [
    makeLabel 'First option',   5, '#84b761'
    makeLabel 'Second option', 15, '#fdd400'
    makeLabel 'Third option',  24, '#cc4748'
    makeLabel 'Fourth option', 33, '#67b7dc'
  ]

  export:
    enabled: true

polarScatter = (graphs) ->
  type: 'radar'
  theme: 'light'
  dataProvider: []
  valueAxes: [
    gridType: 'circles'
    minimum: 0
  ]
  startDuration: 1
  polarScatter:
    minimum: 0
    maximum: 359
    step: 1
  legend:
    position: 'right'
  graphs: graphs
  export:
    enabled: true

parse_data = (data) ->
  data.map (d) -> console.log transform d ; transform d

transform = (datum) ->
  diff = datum.picks.find (d) -> d.question_id == 4
  [datum.contact.id % 120, parseInt(diff.alternative_id) - 9]

fill_resultset = (id) ->
  $.ajax "/products/#{id}/results.json",
    success: (data) ->
      graphs = [
        makeGraphs "Trial #1", [[83,5.1],[44,5.8],[76,9],[2,1.4],[100,8.3],[96,1.7],[68,3.9],[0,3],[100,4.1],[16,5.5],[71,6.8],[100,7.9],[9,6.8],[85,8.3],[51,6.7],[95,3.8],[95,4.4],[1,0.2],[107,9.7],[50,4.2],[42,9.2],[35,8],[44,6],[64,0.7],[53,3.3],[92,4.1],[43,7.3],[15,7.5],[43,4.3],[90,9.9]]
        makeGraphs "Trial #2", [[178,1.3],[129,3.4],[99,2.4],[80,9.9],[118,9.4],[103,8.7],[91,4.2],[151,1.2],[168,5.2],[168,1.6],[152,1.2],[149,3.4],[182,8.8],[106,6.7],[111,9.2],[130,6.3],[147,2.9],[81,8.1],[138,7.7],[107,3.9],[124,0.7],[130,2.6],[86,9.2],[169,7.5],[122,9.9],[100,3.8],[172,4.1],[140,7.3],[161,2.3],[141,0.9]] 
        makeGraphs "Trial #3", [[419,4.9],[417,5.5],[434,0.1],[344,2.5],[279,7.5],[307,8.4],[279,9],[220,8.4],[204,8],[446,0.9],[397,8.9],[351,1.7],[393,0.7],[254,1.8],[260,0.4],[300,3.5],[199,2.7],[182,5.8],[173,2],[201,9.7],[288,1.2],[333,7.4],[308,1.9],[330,8],[408,1.7],[274,0.8],[296,3.1],[279,4.3],[379,5.6],[175,6.8]]  
      ]

      graphs = [
        makeGraphs "Trial all", parse_data(data)
      ]
      
      AmCharts.makeChart "result", polarScatter(graphs)

fill_resultset "1"