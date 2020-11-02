name "<%= app %>"
spec(
  timeoutSec: 40,
  connectionDraining: {
    drainingTimeoutSec: 60,
  },
  sessionAffinity: {
    affinityType: "CLIENT_IP",
  }
)
