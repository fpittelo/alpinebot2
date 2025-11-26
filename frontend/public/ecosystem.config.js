module.exports = {
  apps: [{
    name: "frontend",
    script: "serve",
    env: {
      PM2_SERVE_PATH: '/home/site/wwwroot',
      PM2_SERVE_PORT: 3000,
      PM2_SERVE_SPA: 'true',
      PM2_SERVE_HOMEPAGE: '/index.html'
    }
  }]
}
