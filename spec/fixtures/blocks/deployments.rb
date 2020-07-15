deployment "demo-web" do
  labels(app: name)
  image "nginx"
end

deployment "demo-web-2" do
  labels(app: name)
  image "nginx"
end
