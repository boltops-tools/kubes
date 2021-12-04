# Docs: https://kubes.guru/docs/config/hooks/docker/

before("build",
  execute: "echo 'docker build before hook'",
)

after("build",
  execute: "echo 'docker build after hook'",
)
