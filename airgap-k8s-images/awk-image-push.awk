BEGIN {print "#!/bin/bash -x"}
$0 ~ /^artifact\-public\.instana\.io/ {printf("%s push ", docker_podman); sub("artifact-public.instana.io", local_image_registry, $0); print} 
$0 ~ /^docker\.io/ {printf("%s push ", docker_podman); sub("docker.io", local_image_registry, $0); print} 
$0 ~ /^quay\.io/ {printf("%s push ", docker_podman); sub("quay.io", local_image_registry, $0); print} 
$0 ~ /^docker\.elastic\.co/ {printf("%s push ", docker_podman); sub("docker.elastic.co", local_image_registry, $0); print} 
$0 ~ /^registry\.opensource\.zalan\.do/ {printf("%s push ", docker_podman); sub("registry.opensource.zalan.do", local_image_registry, $0); print} 
$0 ~ /^ghcr\.io/ {printf("%s push ", docker_podman); sub("ghcr.io", local_image_registry, $0); print} 
