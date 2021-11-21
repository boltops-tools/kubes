# Docs: https://kubes.guru/docs/config/hooks/kubes/

before("apply",
  execute: "echo 'kubes before apply hook'",
)

after("apply",
  execute: "echo 'kubes after apply hook'",
)
