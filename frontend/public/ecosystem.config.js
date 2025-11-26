module.exports = {
  apps: [{
    name: "frontend",
    script: "./server.js",
    cwd: "/home/site/wwwroot",
    env: {
      PORT: 3000
    }
  }]
}
