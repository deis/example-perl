# Perl Quick Start Guide

This guide will walk you through deploying a Perl application on [Deis Workflow][].

## Usage

```console
$ deis create --buildpack https://github.com/miyagawa/heroku-buildpack-perl.git
Creating application... done, created violet-valkyrie
Creating config... done, v2

=== violet-valkyrie
BUILDPACK_URL: https://github.com/miyagawa/heroku-buildpack-perl.git
Git remote deis added
$ git push deis master
Counting objects: 34, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (29/29), done.
Writing objects: 100% (34/34), 8.73 KiB | 0 bytes/s, done.
Total 34 (delta 10), reused 0 (delta 0)
-----> Fetching custom buildpack
-----> Perl/PSGI app detected
-----> Bootstrapping cpanm
       Successfully installed App-cpanminus-1.7039
       1 distribution installed
-----> Installing dependencies
       Successfully installed IO-Socket-IP-0.37
       Successfully installed Mojolicious-6.13
       2 distributions installed
-----> Installing Starman
       Successfully installed ExtUtils-Helpers-0.022
       Successfully installed Test-Harness-3.35
...
       33 distributions installed
-----> Discovering process types
       Default process types for Perl/PSGI -> web
-----> Compiled slug size is 1.8M

-----> Building Docker image
remote: Sending build context to Docker daemon 1.891 MB
remote: build context to Docker daemon
Step 0 : FROM deis/slugrunner
 ---> 7fca3523a364
Step 1 : RUN mkdir -p /app
 ---> Running in 0ce46da6b681
 ---> 00a2c877647c
Removing intermediate container 0ce46da6b681
Step 2 : WORKDIR /app
 ---> Running in d97e97c3de1a
 ---> 8f89e6fa7416
Removing intermediate container d97e97c3de1a
Step 3 : ENTRYPOINT /runner/init
 ---> Running in 55b94ecb8863
 ---> f4b53afbab5c
Removing intermediate container 55b94ecb8863
Step 4 : ADD slug.tgz /app
 ---> fde80f19d0c5
Removing intermediate container 3d32fdbe942a
Step 5 : ENV GIT_SHA 0555569d98dd2be21647ec328adc0548542fe93e
 ---> Running in c0ec02eac12b
 ---> 813686a33583
Removing intermediate container c0ec02eac12b
Successfully built 813686a33583
-----> Pushing image to private registry

-----> Launching...
       done, violet-valkyrie:v3 deployed to Deis

       http://violet-valkyrie.local3.deisapp.com

       To learn more, use `deis help` or visit http://deis.io

To ssh://git@deis.local3.deisapp.com:2222/violet-valkyrie.git
 * [new branch]      master -> master
$ curl http://violet-valkyrie.local3.deisapp.com
Powered by Deis
$ deis config:set POWERED_BY="Engine Yard"
Creating config... done, v4

=== violet-valkyrie
DEIS_APP: violet-valkyrie
BUILDPACK_URL: https://github.com/miyagawa/heroku-buildpack-perl.git
POWERED_BY: Engine Yard
$ curl http://violet-valkyrie.local3.deisapp.com
Powered by Engine Yard
```

## Additional Resources

* [GitHub Project](https://github.com/deis/workflow)
* [Documentation](https://deis.com/docs/workflow/)
* [Blog](https://deis.com/blog/)

[Deis Workflow]: https://github.com/deis/workflow#readme
