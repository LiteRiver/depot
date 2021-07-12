App.products = App.cable.subscriptions.create 'ProductsChannel',
connected: ->
disconnected: ->
received: (data) -> 
	document.getElementsByTagName('main')[0].innerHTML = data.html
