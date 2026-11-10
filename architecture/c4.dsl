# C4 model fragment - Offbeat-IoT/jaeger-one-in-all
# Consumed by Offbeat-IoT/information/scripts/c4/build.py.

jaeger_one_in_all = softwareSystem "Jaeger All-in-One" "Tracing backend for the platform: receives OTLP and legacy Jaeger spans from the instrumented services and serves the trace UI on observability1. Deployed with docker compose by its Jenkins multibranch pipeline." {
  tags "tooling"

  jaeger = container "Jaeger" "Accepts traces over OTLP gRPC and HTTP (4317, 4318) and the legacy Jaeger protocols, keeps them in in-memory storage and serves the query UI and API on 16686." "Jaeger v2 all-in-one"
}
