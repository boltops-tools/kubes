name "web"
labels(app: "<%= app %>") # IE: backend
namespace "<%= app %>"    # IE: backend

matchLabels(app: "<%= app %>", role: "<%= role %>") # IE: app: backend
fromNamespace(app: "<%= app %>") # IE: app: frontend
fromPod(app: "<%= app %>")       # IE: backend
