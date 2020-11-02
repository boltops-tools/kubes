name "web"
labels(role: "web")

replicas 1 # overridden on a env basis
image docker_image # IE: user/<%= app %>:kubes-2020-06-13T19-55-16-43afc6e

# revisionHistoryLimit 1 # uncomment to reduce old ReplicaSets, default is 10 https://bit.ly/3hqrzyP
# maxUnavailable 25

# More docs: kubes.guru/docs/dsl/resources/deployment/

