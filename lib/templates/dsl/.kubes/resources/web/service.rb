name "web"
labels(role: "web")

# Optional since default port is 80
# port 80
targetPort dockerfile_port # expose port in Dockerfile

# More docs: kubes.guru/docs/dsl/service/
