import { Router } from "express"
import { healthCheckHandler } from "./healthcheck"
import { resolve } from "path"

export function createApiRouter() {
  const router = Router()
  router.get('/healthcheck', healthCheckHandler)
  router.use((_, res) => {
    res.sendStatus(404)
  })
  return router
}
