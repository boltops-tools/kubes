name "<%= app %>"
containers([
  image: docker_image,
  command: ["sleep", "3600"],
  name: "<%= app %>",
])
