<scatter-chart>
  <div id="{ opts.name }" style="width:400px; height:400px; margin: 0 auto;"></div>

  <script type="coffee">
    data = JSON.parse(opts.data)

    makeGraphs = (title, series) ->
      # title: title
      # balloonText: "[[category]]: [[value]] m/s"
      balloonText: "hola soy un globo"
      bullet: 'round'
      bulletSize: 15
      lineAlpha: 0
      series: series

    polarScatter = () ->
      type: 'radar'
      theme: 'light'
      dataProvider: []
      valueAxes: [
        gridType: 'circles'
        minimum: 0
        maximum: 3
        axisFrequency: 120
        labelsEnabled: false
        axisThickness: 1.5
        axisTitleOffset: 300
      ]
      allLabels: [
        text: "Informar"
        bold: true
        x: 330
        y: 110
      ,
        text: "Introducir"
        bold: true
        x: 5
        y: 110
      ,
        text: "Orientar"
        bold: true
        x: 175
        y: 355
    ]
      startDuration: 0.3
      polarScatter:
        minimum: 0
        maximum: 359
        step: 1
      # legend:
      #   position: 'right'
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