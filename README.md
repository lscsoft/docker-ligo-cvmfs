# ligo/cvmfs

This container is intended for use as a lightweight virtual machine that
replicates a LIGO software environment on all operating systems. It includes
a default user (albert) and command-line environment.

It is intended to be a "terminal" image that other containers should not build
from. `ligo/software` is the correct container to use in tools like GitLab CI
and Travis CI and should be used to construct derivative containers.

## Running on MacOS
The following command will ensure that user home directories are mounted in
such a way that the albert user has the same level of access as your account.
Privileged access is necessary to mount filesystems; it is an access level you
already have on your workstation and are delegating it to Docker. If you are
on a shared system, this may have security implications you should consider.
```
docker run -it --privileged -v $(grid-proxy-info -path):/tmp/x509up_u1000 -v /Users:/Users ligo/cvmfs:latest
```

## Running on Linux
This will not map user ids in the same automatic way as on MacOS, but it will provide limited
access to user home directories.
```
docker run -it --privileged -v $(grid-proxy-info -path):/tmp/x509up_u1000 -v /home:/home ligo/cvmfs:latest
```
