# Docs: https://kubes.guru/docs/config/hooks/kubectl/

before("apply",
  on: "web/deployment",
  execute: "echo 'before apply hook test'",
)

after("delete",
  on: "web/deployment",
  execute: "echo 'after delete hook test'",
)
