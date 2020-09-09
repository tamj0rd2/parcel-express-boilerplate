import { RequestHandler } from "express";

export const healthCheckHandler: RequestHandler = (_, res, next) => {
  res.status(200).send('Nice stuff!')
}
