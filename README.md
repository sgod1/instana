# instana

#### bootstrap installation version.
Run: `bootstrap-install-version.sh 262 ~/tmp2`

Edit `custom.env` as needed.<br/>

Run: `1-update-environment.sh`<br/>


#### todo
Configure your image registry to proxy Instana's image registry (containers.instana.io) transparently.<br/>

#### outbound endpoints

The following repository needs to be accessed to download the actual Instana backend images that are used by Docker-based backend installer and the kubectl plug-in:

Repository: https://artifact-public.instana.io

    Port: 443
    Protocol: HTTPS
    Authentication: yes

Accounting Backend: https://instana.io/portal/statistics/usage

    Port: 443
    Protocol: HTTPS
    Authentication: no



The following repository needs to be accessed to download static host agents and dynamic host agents:

Repository: https://containers.instana.io

    Port: 443
    Protocol: HTTPS
    Authentication: no



The following repository needs to be accessed to download agent images from the IBM Cloud Container Registry (ICR):

Repository: https://icr.io/instana

    Port: 443
    Protocol: HTTPS
    Authentication: no


The following repository needs to be accessed if you want to use the packages installation method to install the host agent:

Repository: https://packages.instana.io/

    Port: 443
    Protocol: HTTPS
    Authentication: no



The following repository needs to be accessed if you want to use the one-liner Installation procedure to install the host agent:

Repository: https://setup.instana.io/

    Port: 443
    Protocol: HTTPS
    Authentication: no


New sensors, updates to existing sensors, and agent updates are pulled daily from the following repository if dynamic agents are installed:

Repository: http://artifact-public.instana.io/

    Port: 443
    Protocol: HTTPS
    Authentication: yes


The following URL repository needs to be accessed to store Synthetic PoP Helm packages, autotrace-webhook, and agent Helm packages:

Repository: https://agents.instana.io/helm

    Port: 443
    Protocol: HTTPS
    Authentication: yes

#### Agents.
agents helm repo: helm repo add agents https://agents.instana.io/helm

Static instatna agent container github:
https://github.com/instana/instana-agent-docker/tree/main/static

Prebuild images:
docker login containers.instana.io -u _ -p <agent_key>
docker pull containers.instana.io/instana/release/agent/static:latest

If you want to deploy the static host agent, set the flag:
—set agent.image.name=containers.instana.io/instana/release/agent/static in the helm installation command.

agent ports: 42699, 16816/php, 4317/ot grpc
