@Library('shared-jenkins-pipelines@main') _

// Deploy the single-node Jaeger stack on observability1 with the shared stack
// pipeline. observability1 runs plain `docker compose`, not a Swarm.
stackRepoCiPipeline(
    buildNode: 'observability',
    deployMode: 'compose',
    sourceRepo: 'Offbeat-IoT/jaeger-one-in-all',
    runProductionDeploy: false
)
