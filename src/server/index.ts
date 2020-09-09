import express from 'express'
import Bundler from 'parcel-bundler'
import { createApiRouter } from './api'

const config = { 
  PORT: 8080
}
const bundler = new Bundler('src/client/index.html', {
  sourceMaps: process.env.NODE_ENV !== 'production',
})

const app = express()
app.use('/api', createApiRouter())
app.use(bundler.middleware())
app.listen(config.PORT, () => {
  console.log(`Server listening on http://localhost:${config.PORT}`)
})
