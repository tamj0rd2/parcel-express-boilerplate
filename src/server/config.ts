export interface ServerConfig {
  PORT: number
  ALLOWED_CREDENTIALS: Record<string, string>
}

export const getServerConfig = (): ServerConfig => {
  return {
    PORT: 8080,
    ALLOWED_CREDENTIALS: {
      username: 'password',
    },
  }
}
