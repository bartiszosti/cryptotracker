WorkerScript.onMessage = (message) => {
  const request = new XMLHttpRequest();

  request.onabort = () => WorkerScript.sendMessage({
    "status": request.status,
    "data": "aborted"
  })

  request.onerror = () => WorkerScript.sendMessage({
    "status": request.status,
    "data": "error"
  })

  request.ontimeout = () => WorkerScript.sendMessage({
    "status": request.status,
    "data": "timeout"
  })

  request.onload = () => {
    let result = {
      "status": request.status,
      "data": []
    };

    if(request.status === 200) {
      const json = JSON.parse(request.response)

      for(let element in json)
        result.data.push({
          "image": json[element].image,
          "name": json[element].name,
          "current_price": json[element].current_price,
          "price_change_percentage_24h": json[element].price_change_percentage_24h,
          "total_volume": json[element].total_volume,
          "market_cap": json[element].market_cap,
          "last_updated": json[element].last_updated
        })

      if((message.sortBy > -1) && (message.sortBy < 12)) {
        let compareFunctions = [];

        compareFunctions.push((a, b) => a.name.localeCompare(b.name));
        compareFunctions.push((a, b) => b.name.localeCompare(a.name))
        compareFunctions.push((a, b) => a.current_price - b.current_price)
        compareFunctions.push((a, b) => b.current_price - a.current_price)
        compareFunctions.push((a, b) => a.price_change_percentage_24h - b.price_change_percentage_24h)
        compareFunctions.push((a, b) => b.price_change_percentage_24h - a.price_change_percentage_24h)
        compareFunctions.push((a, b) => a.total_volume - b.total_volume)
        compareFunctions.push((a, b) => b.total_volume - a.total_volume)
        compareFunctions.push((a, b) => a.market_cap - b.market_cap)
        compareFunctions.push((a, b) => b.market_cap - a.market_cap)
        compareFunctions.push((a, b) => new Date(a.last_updated) - new Date(b.last_updated))
        compareFunctions.push((a, b) => new Date(b.last_updated) - new Date(a.last_updated))

        result.data.sort(compareFunctions[message.sortBy])
      }
    }
    else result.data = request.response;

    WorkerScript.sendMessage(result)
  }

  request.open("GET", "https://api.coingecko.com/api/v3/coins/markets?vs_currency=" + message.currency, true)
  request.setRequestHeader("accept", "application/json")
  request.send()
}
