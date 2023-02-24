const notifier = require("node-notifier")
const axios = require("axios")
const fs = require("fs")
const path = require("path")
const nodeFetch = require("node-fetch")
const { exec } = require("child_process")

;(async () => {
  const picReq = await axios.get(
    "https://api.saintkappa.xyz/moses/pics/random?json=true"
  )
  const request = await axios.get(
    "https://api.saintkappa.xyz/moses/quotes/random"
  )
  const imageUrl = picReq.data.url
  nodeFetch(imageUrl)
    .then((res) => res.body.pipe(fs.createWriteStream("./cache/image.png")))
    .then(() => {
      const quote = request.data.quote
      const quoteId = request.data.quoteId
      notifier.notify(
        {
          title: `Hello! Here's your random Moses' quote! #${quoteId}`,
          message: `${quote}`,
          icon: path.join(__dirname, "/cache/image.png"),
          sound: false,
          open: imageUrl,
        },
        function (error, response, metadata) {
          if (metadata.action === "clicked") {
            exec(`start "" "${imageUrl}"`)
          }
        }
      )
    })
})()