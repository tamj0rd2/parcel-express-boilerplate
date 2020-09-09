import { createAuthMiddleware } from './auth'
import { ServerConfig } from '../config'
import { RequestHandler } from 'express'

export default function createMiddlewares(config: ServerConfig): RequestHandler[] {
  return [createAuthMiddleware(config)]
}
