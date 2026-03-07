# Jaeger Repo Notes

## Update Jaeger Version

1. Work in a feature branch from `main`.
2. Check the latest Jaeger release tag from the upstream releases page:
   `https://github.com/jaegertracing/jaeger/releases`
3. Confirm the image tag exists:
   `docker manifest inspect cr.jaegertracing.io/jaegertracing/jaeger:<version>`
4. Update [`docker-compose.yml`](/C:/cygwin64/home/soere/repos/codex-work/jaeger-one-in-all/docker-compose.yml) to:
   - set `image: cr.jaegertracing.io/jaegertracing/jaeger:<version>`
   - keep `restart: unless-stopped`
5. Validate locally:
   `docker compose config`
6. Commit and push the branch.

## Deploy Through Jenkins

1. Do not deploy manually on `observability1`.
2. Push the feature branch and let the multibranch job deploy it:
   `observability-tools/Jaeger/jaeger-ci/<branch>`
3. The pipeline runs on the `observability1` Jenkins agent and executes:
   `docker compose up -d`
4. Wait for the branch build to finish with `SUCCESS`.

## Verify Deployment

1. Check the UI:
   `http://observability1:16686/`
   Expected result: `HTTP 200`
2. Check the running container on `observability1`:
   `docker inspect jaeger --format '{{.Config.Image}} {{.HostConfig.RestartPolicy.Name}} {{.State.Status}}'`
   Expected result: the requested image tag, `unless-stopped`, and `running`
3. Check that Jaeger sees instrumented services:
   `http://observability1:16686/api/services`
   Expected result: a non-empty `data` array
4. Check recent traces for active services such as `soren-app`, `grafana`, or `keycloak`:
   - `http://observability1:16686/api/traces?service=soren-app&limit=3&lookback=1h`
   - `http://observability1:16686/api/traces?service=grafana&limit=3&lookback=1h`
   - `http://observability1:16686/api/traces?service=keycloak&limit=3&lookback=1h`
5. To confirm traces are still arriving after deployment, fetch the latest trace for an active service twice a few seconds apart and verify the newer response has a later timestamp or different trace ID.

## Notes

- This deployment uses Jaeger all-in-one with in-memory storage.
- After a container restart, old traces are gone. Any services or traces visible after restart were ingested after that restart.
