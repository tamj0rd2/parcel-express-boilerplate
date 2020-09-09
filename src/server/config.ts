export interface ServerConfig {
  PORT: number
  ALLOWED_CREDENTIALS: Record<string, string>
}

export const getServerConfig = (): ServerConfig => {
  if (!process.env.PORT) throw new Error('No port!')

  return {
    PORT: parseInt(process.env.PORT),
    ALLOWED_CREDENTIALS: {
      username: 'password',
    },
  }
}
