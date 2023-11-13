BEGIN {print "#!/bin/bash -x"}
$0 ~ /^artifact\-public\.instana\.io/ {printf("%s tag %s ", docker_podman, $0); sub("artifact-public.instana.io", local_image_registry, $0); print} 
$0 ~ /^docker\.io/ {printf("%s tag %s ", docker_podman, $0); sub("docker.io", local_image_registry, $0); print} 
$0 ~ /^quay\.io/ {printf("%s tag %s ", docker_podman, $0); sub("quay.io", local_image_registry, $0); print} 
$0 ~ /^docker\.elastic\.co/ {printf("%s tag %s ", docker_podman, $0); sub("docker.elastic.co", local_image_registry, $0); print} 
$0 ~ /^registry\.opensource\.zalan\.do/ {printf("%s tag %s ", docker_podman, $0); sub("registry.opensource.zalan.do", local_image_registry, $0); print} 
$0 ~ /^ghcr\.io/ {printf("%s tag %s ", docker_podman, $0); sub("ghcr.io", local_image_registry, $0); print} 
$0 == "registry.access.redhat.com/ubi8/ubi-minimal:8.8-1014" {printf("%s tag %s ", docker_podman, $0); sub("registry.access.redhat.com", local_image_registry, $0); sub("8.8-1014", "latest", $0); print}
