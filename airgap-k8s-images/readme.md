#### environment

Create environment by running `initialize-env.sh` script or it's os-arch specific variants.<br/>

Look at the versions/version-release-subrelease.md file for release and version values.<br/>

Environment is generated in $envdir/$version directory.<br/>

```
download_key="my-download-key"
envdir="~/instana/env"
release="259"
subrelease="0"
version="260"

./initialize-env-darwin-amd64.sh $download_key $envdir $release $subrelease $version
```


### image scripts
Run `build-image-scripts.sh` script to genereate image scripts in $envdir/$version directory.

```
envdir="~/instana/env"
version="260"
local_image_registry="my.local.image.registry"

./build-image-scripts.sh "$envdir" $version $local_image_registry
```

Change to $envdir/$version directory.<br/>

```
ls -ltr
total 162016
-rwxr-xr-x  1 simon  staff  56680512 Oct 17 04:45 kubectl-instana
-rw-r--r--  1 simon  staff  25718936 Oct 17 04:46 kubectl-instana-darwin_amd64-release-259-0.tar.gz
-rw-r--r--  1 simon  staff      1077 Nov 13 09:42 operator-images.list
-rw-r--r--  1 simon  staff      3543 Nov 13 09:42 instana-images.list
-rwxr-xr-x  1 simon  staff       337 Nov 13 09:47 login-instana-image-registry.sh
-rwxr-xr-x  1 simon  staff      3863 Nov 13 09:47 pull-instana-images.sh
-rwxr-xr-x  1 simon  staff       955 Nov 13 09:47 pull-operator-images.sh
-rwxr-xr-x  1 simon  staff      6640 Nov 13 09:47 tag-instana-images.sh
-rwxr-xr-x  1 simon  staff      1766 Nov 13 09:47 tag-operator-images.sh
-rwxr-xr-x  1 simon  staff       510 Nov 13 09:47 login-local-image-registry.sh
-rwxr-xr-x  1 simon  staff      3455 Nov 13 09:47 push-instana-images.sh
-rwxr-xr-x  1 simon  staff      1034 Nov 13 09:47 push-operator-images.sh
```

There is os and version-specific `kubectl-instana` plugin, scripts to login into registries, and scripts to pull, tag, and push images.<br/>
