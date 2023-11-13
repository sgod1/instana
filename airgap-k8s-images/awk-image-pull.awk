BEGIN {print "#!/bin/bash -x"}
$0 !~ /^#/ {printf("%s pull %s\n", docker_podman, $0)}
