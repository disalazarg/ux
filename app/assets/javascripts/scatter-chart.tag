<scatter-chart>
  <div id="{ opts.name }" style="width:600px; height:400px;"></div>

  <script type="coffee">
    data = JSON.parse(opts.data)

    makeGraphs = (title, series) ->
      title: title
      balloonText: "[[category]]: [[value]] m/s"
      bullet: 'round'
      lineAlpha: 0
      series: series

    polarScatter = () ->
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
      graphs: [
        makeGraphs "Trial #1", data[0]
        makeGraphs "Trial #2", data[1]
        makeGraphs "Trial #3", data[2]
      ]
      export:
        enabled: true

    @on 'mount', () =>
      @chart = AmCharts.makeChart opts.name, polarScatter()
  </script>
</scatter-chart>