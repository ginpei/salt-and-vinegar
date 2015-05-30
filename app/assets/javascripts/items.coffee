# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ajax:send', '#new_item, .js-item-form', (event, ajax)->
  $form = $(event.currentTarget)
  $form.find('input, select, textarea, button')
    .attr('disabled', true)

$(document).on 'ajax:complete', '#new_item, .js-item-form', (event, ajax, status)->
  $form = $(event.currentTarget)
  $form.find('input, select, textarea, button')
    .attr('disabled', false)

$(document).on 'ajax:success', '#new_item', (event, data, ajax, status)->
  $form = $(event.currentTarget)
  $form.find('[name="item[name]"], [name="item[quantity]"]')
    .val('')
  $('#items_list').append(data.html)

$(document).on 'ajax:success', '.js-item-form', (event, data, ajax, status)->
  $row =  $(event.currentTarget).closest('.item')

  html = data.html
  $row.replaceWith(html)

$(document).on 'ajax:error', '#new_item, .js-item-form', (event, ajax, status, statusText)->
  data = JSON.parse(ajax.responseText)
  messages = data.messages

  if messages.length > 1
    text = messages
      .map (message, index) -> return "* #{message}\n"
      .join('')
  else
    text = messages[0]

  alert text

$(document).on 'ajax:send', '.delete_item', (event, data, ajax, status)->
  $form = $(event.currentTarget)
  $row = $form.closest('.item')
  $row.remove()

$(document).on 'click', '.js-openEditItemForm', (event)->
  $row = $(event.currentTarget).closest('.item')
  $button = $row.find('.js-openEditItemForm')
  $form = $row.find('.js-item-form')

  $button.hide()
  $form.show()

$(document).on 'click', '.js-hideEditItemForm', (event)->
  $row = $(event.currentTarget).closest('.item')
  $button = $row.find('.js-openEditItemForm')
  $form = $row.find('.js-item-form')

  $button.show()
  $form.hide()
