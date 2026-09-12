module.exports = {
  apps: [
    {
      name: "devops-tracker",
      cwd: "/root/dev/devops",
      script: "./serve-docs.sh",
      interpreter: "bash",
      autorestart: true,
      watch: false,
      max_memory_restart: "300M",
      env: {
        PATH: `${process.env.HOME}/.local/bin:${process.env.HOME}/.cache/pipx/bin:/usr/local/bin:/usr/bin:/bin`,
        PYTHONUNBUFFERED: "1"
      }
    }
  ]
};
