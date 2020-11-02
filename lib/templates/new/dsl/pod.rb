name "<%= app %>"
containers([
  image: built_image,
  command: ["sleep", "3600"],
  name: "<%= app %>",
])
