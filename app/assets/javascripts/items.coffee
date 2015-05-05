# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ajax:send', '#new_item', (event, ajax)->
  $form = $(event.currentTarget)
  $form.find('input, select, textarea, button')
    .attr('disabled', true)

$(document).on 'ajax:complete', '#new_item', (event, ajax, status)->
  $form = $(event.currentTarget)
  $form.find('input, select, textarea, button')
    .attr('disabled', false)

$(document).on 'ajax:success', '#new_item', (event, data, ajax, status)->
  $form = $(event.currentTarget)
  $form[0].reset()
  alert data.message

$(document).on 'ajax:error', '#new_item', (event, data, ajax, status)->
  alert 'Error'  # FIXME
