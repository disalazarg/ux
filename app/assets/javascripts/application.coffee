#= require jquery
#= require bootstrap-sprockets
#= require amcharts
#= require radar
#= require polar-scatter
#= require gauge
#= require riot
#= require riot_rails
#= require jquery_ujs
#  require turbolinks
#= require gauge-chart
#= require scatter-chart
#= require_tree .

document.addEventListener 'DOMContentLoaded', () ->
  riot.mount '*'

  window.load_districts = (self) ->
    val = $(self).val()

    $.ajax
      url:      "/regions/#{val}/districts.json?page=all"
      dataType: "json"
      type:     "GET"
      success: (result) =>
        select       = $('#districts')
        empty_option = $('#districts option:first-child')

        $(select)
          .empty()
          .append(empty_option)

        $(result).each (index, district) =>
          select
            .append($ "<option>", { value: district.id, text: district.name })