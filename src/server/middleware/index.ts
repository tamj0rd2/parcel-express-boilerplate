import { createAuthMiddleware } from './auth'
import { ServerConfig } from '../config'

export default function createMiddlewares(config: ServerConfig)  {
  return [createAuthMiddleware(config)]
}

