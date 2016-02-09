unless window.onomatopia
  window.onomatopia = {
    $document: $(document)
  }

window.onomatopia.item = (
  addAction: (selector, type, listener) ->
    window.onomatopia.$document.on(type, selector, listener)

  initialize: () ->
    @addAction '.js-openEditItemForm', 'click',
      (event)=> @_openEditForm(@_findEventRow(event))

    @addAction '.js-closeEditItemForm', 'click',
      (event)=> @_closeEditForm(@_findEventRow(event))

    @addAction '.js-itemForm', 'ajax:send',
      (event, ajax)=> @_lockForm(@_findEventForm(event))

    @addAction '.js-itemForm', 'ajax:complete',
      (event, ajax)=> @_unlockForm(@_findEventForm(event))

    @addAction '.js-itemForm-new', 'ajax:success',
      (event, data, ajax, status)=>
        $form = @_findEventForm(event)
        @_appendCreatedItem($form, data)
        @_scrollToForm(@_findEventForm(event))

    @addAction '.js-itemForm-edit', 'ajax:success',
      (event, data, ajax, status)=> @_replaceUpdatedItem(@_findEventRow(event), data)

    @addAction '.js-itemDeleteForm', 'ajax:send',
      (event, data, ajax, status)=> @_deleteItem(@_findEventRow(event))

    @addAction '.js-itemForm', 'ajax:error',
      (event, ajax, status, statusText)=>
        @_unlockForm(@_findEventForm(event))
        @_showFormErrors(ajax)

  _findEventForm: (event)->
    $(event.currentTarget).closest('.js-itemForm')

  _findEventRow: (event)->
    $(event.currentTarget).closest('.js-itemForm-item')

  _findRowForm: ($row)->
    $row.find('.js-itemEditor')

  _findItemTable: ->
    $('#items_list')

  _findFormItems: ($form)->
    $form.find('input, select, textarea, button')

  _getFormErrors: (ajax)->
    @_formatErrorTexts(JSON.parse(ajax.responseText).messages)

  _formatErrorTexts: (messages)->
    if messages.length > 1
      messages
        .map (message, index) -> return "* #{message}\n"
        .join('')
    else
      messages[0]

  _openEditForm: ($row)->
    $form = @_findRowForm($row)
    $cells = $row.children()
    $formCell = $cells.first().clone()
      .empty()
      .attr('colspan', $cells.length)

    $cells.remove()
    $formCell
      .data('originals', $cells)
      .append($form.clone().removeClass('is-hidden'))
      .appendTo($row)

  _closeEditForm: ($row)->
    $formCell = $row.children()
    $cells = $formCell.data('originals')

    $formCell.remove()
    $cells.appendTo($row)

  _lockForm: ($form)->
    @_findFormItems($form).attr('disabled', true)

  _unlockForm: ($form)->
    @_findFormItems($form).attr('disabled', false)

  _appendCreatedItem: ($form, data)->
    $items = @_findItemTable()
    $continuables = $form.find('.js-continuable')
    $firstInput = $continuables.eq(0)

    $items.append(data.html)
    $continuables.val('')
    setTimeout (-> $firstInput.focus()), 1  # execute after unlocking

    message = @_makeMessageForNewItems(data.items)
    Materialize.toast(message, 4000)

  _makeMessageForNewItems: (items)->
    item_length = items.length
    if item_length is 1
      "#{@_safeItemNameForToast(items[0].name, 16)} is added."
    else if item_length is 2
      "#{@_safeItemNameForToast(items[0].name, 8)} and #{@_safeItemNameForToast(items[1].name, 8)} are added."
    else
      "#{item_length} items are added."

  _safeItemNameForToast: (name, length)->
    if name.length > length
      name_shortened = name.slice(0, length-2) + '...'
    else
      name_shortened = name
    $('<div>').text(name_shortened).html()

  _scrollToForm: ($form)->
    MARGIN = 50
    top = $form.offset().top - MARGIN
    window.onomatopia.$document.scrollTop(top)

  _replaceUpdatedItem: ($row, data)->
    $row.replaceWith(data.html);

  _deleteItem: ($row)->
    $row.remove()

  _showFormErrors: (ajax)->
    alert @_getFormErrors(ajax)

  __setup: ->
    $ => @__autoplay()
    return @
  __autoplay: ->
    @initialize()
).__setup();
