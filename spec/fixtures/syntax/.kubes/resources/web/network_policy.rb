name "demo-web-allow-tester"
matchLabels(role: "web")
fromPod(run: "tester")
