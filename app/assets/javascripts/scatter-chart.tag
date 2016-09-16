<scatter-chart>
  <div id="{ opts.name }" style="width:600px; height:400px;"></div>

  <script type="coffee">
    makeGraphs = (title) ->
      title: title
      balloonText: "[[category]]: [[value]] m/s"
      bullet: 'round'
      lineAlpha: 0
      valueField: "data"

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
        makeGraphs "Trial #1"
        makeGraphs "Trial #2"
        makeGraphs "Trial #3"
      ]
      export:
        enabled: true

    @on 'mount', () =>
      @chart = AmCharts.makeChart opts.name, polarScatter()

    store.on 'update_data', () =>
      @chart.dataProvider = store.state
      @chart.validateData()

      console.log "updated!"
  </script>
</scatter-chart>