<gauge-chart>
  <div id="{ opts.name }" style="width:600px; height:400px;"></div>

  <script type="coffee">
    data = JSON.parse(opts.data)
    
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
          makeAxis '#84b761', data[0], 100,  85, data[0]
          makeAxis '#fdd400', data[1],  80,  65, data[1]
          makeAxis '#cc4748', data[2],  60,  45, data[2]
        ].reduce (i,a) -> i.concat a
      ]

      allLabels: [
        makeLabel 'First option',   5, '#84b761'
        makeLabel 'Second option', 15, '#fdd400'
        makeLabel 'Third option',  24, '#cc4748'
      ]

      export:
        enabled: true


    @on 'mount', () =>
      AmCharts.makeChart opts.name, gaugeChart()
  </script>

</gauge-chart>