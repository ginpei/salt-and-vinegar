# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', (event)->
  if window.g_page is 'books/item_history'
    snv_books.item_history.setup()

snv_books = {}

# books/1/item_history
snv_books.item_history =
  setup: ()->
    @items = g_items
    @$list = $('.js-itemList')
    @_setup_excell()
    @_render_items(@items)

  _setup_excell: ()->
    @excell = Excell.create
      el: @$list[0]

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
      <td class="book-itemHistory-item-paperTitle">#{h(item.paper_title)}</td>
      <td class="book-itemHistory-item-name">#{h(item.name)}</td>
      <td class="book-itemHistory-item-quantity">#{h(item.quantity)}</td>
      <td class="book-itemHistory-item-orderer">#{h(item.orderer)}</td>
      <td class="book-itemHistory-item-price">#{h(item.price)}</td>
      <td class="book-itemHistory-item-unit">#{h(item.unit)}</td>
    </tr>
    """
