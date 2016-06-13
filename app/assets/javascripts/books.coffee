# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', (event)->
  if g_page is 'books/item_history'
    snv_books.item_history.setup()

snv_books = {}

# books/1/item_history
snv_books.item_history =
  setup: ()->
    @items = g_items
    @$list = $('.js-itemList')
    @_render_items(@items)

  _render_items: (items)->
    html = ''
    items.forEach (item)=>
      html += @_build_item_html(item)
    @$list.html(html)

  _build_item_html: (item)->
    h = (s)->
      if s is null or s is undefined
        ''
      else
        s.toString().replace(/[<>&]/g, (m)->'&#'+m.charCodeAt(0)+';')

    """
    <tr>
      <td>#{h(item.paper_title)}</td>
      <td>#{h(item.name)}</td>
      <td>#{h(item.quantity)}</td>
      <td>#{h(item.orderer)}</td>
      <td>#{h(item.price)}</td>
      <td>#{h(item.unit)}</td>
    </tr>
    """
