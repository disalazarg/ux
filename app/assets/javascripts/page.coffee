# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.load_districts = (self) ->
  val = $(self).val()
  $.ajax
    url: "/regions/#{val}/districts.json"
    dataType: "json"
    type: "GET"
    success: (result) =>
      select = $('#search_district')
      empty_option = $('#search_district option:first-child')
      $(select).empty().append(empty_option)
      $(result).each (index, district) =>
        select.append($("<option></option")
          .attr("value", district.id)
          .text(district.name))
