const express = require('express')

const app = express()
app.get('/', (req, res) => res.send('Hello, World Update'))

app.listen(8080, () => {
  process.stdout.write('App listening on 8080')
})