unless window.onomatopia
  window.onomatopia = {
    $document: $(document)
  }
window.onomatopia.item = (
  initialize: () ->
    @addAction '.js-itemForm', 'ajax:send',     (event, ajax)=> @_lockForm(@_findEventForm(event))
    @addAction '.js-itemForm', 'ajax:complete', (event, ajax)=> @_unlockForm(@_findEventForm(event))

  _findEventForm: (event)->
    $(event.currentTarget).closest('.js-itemForm')

  _findFormItems: ($form)->
    $form.find('input, select, textarea, button')

  _lockForm: ($form)->
    @_findFormItems($form).attr('disabled', true)

  _unlockForm: ($form)->
    @_findFormItems($form).attr('disabled', false)

  __setup: ->
    $ => @__autoplay()
    return @
  __autoplay: ->
    @initialize()
  addAction: (selector, type, listener) ->
    window.onomatopia.$document.on(type, selector, listener)
).__setup();

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
