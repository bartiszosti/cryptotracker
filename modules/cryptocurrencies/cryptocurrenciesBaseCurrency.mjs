WorkerScript.onMessage = () => {
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
          "text": json[element].toUpperCase(),
          "value": json[element]
        })
    }
    else result.data = request.response;

    WorkerScript.sendMessage(result)
  }

  request.open("GET", "https://api.coingecko.com/api/v3/simple/supported_vs_currencies", true)
  request.setRequestHeader("accept", "application/json")
  request.send()
}
