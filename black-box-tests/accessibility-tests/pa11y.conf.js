const WEB_HOST = process.env.WEB_HOST || 'http://localhost:8080'

module.exports = {
  standard: 'WCAG2AA',
  level: 'error',
  defaults: {
    timeout: 45000,
    wait: 3000,
    chromeLaunchConfig: {
      executablePath: '/usr/bin/chromium-browser',
      args: ['--no-sandbox'],
    },
  },
  urls: [
    {
      url: WEB_HOST,
      viewport: {
        width: 1280,
        height: 1024,
      },
      actions: ['wait for element h1 to be visible'],
    },
  ],
}
