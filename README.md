# Perl Quick Start Guide

This guide will walk you through deploying a Perl application on [Deis Workflow][].

## Usage

```console
$ git clone https://github.com/deis/example-perl.git
$ cd exmaple-perl
$ deis create --buildpack https://github.com/miyagawa/heroku-buildpack-perl.git
Creating Application... done, created blurry-kingfish
Git remote deis added
remote available at ssh://git@deis-builder.deis.rocks:2222/blurry-kingfish.git
$ git push deis master
Counting objects: 41, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (36/36), done.
Writing objects: 100% (41/41), 11.10 KiB | 0 bytes/s, done.
Total 41 (delta 12), reused 0 (delta 0)
Starting build... but first, coffee!
-----> Fetching custom buildpack
-----> Perl/PSGI app detected
-----> Bootstrapping cpanm
       Successfully installed App-cpanminus-1.7042
       1 distribution installed
-----> Installing dependencies
       cpanm options: --quiet --notest -l /tmp/build/local
       Successfully installed IO-Socket-IP-0.37
...
       Successfully installed Starman-0.4014
       33 distributions installed
-----> Discovering process types
       Default process types for Perl/PSGI -> web
-----> Compiled slug size is 1.9M
Build complete.
Launching App...
Done, blurry-kingfish:v3 deployed to Deis

Use 'deis open' to view this application in your browser

To learn more, use 'deis help' or visit https://deis.com/

To ssh://git@deis-builder.deis.rocks:2222/blurry-kingfish.git
 * [new branch]      master -> master
$ curl http://blurry-kingfish.deis.rocks
Powered by Deis
```

## Additional Resources

* [GitHub Project](https://github.com/deis/workflow)
* [Documentation](https://deis.com/docs/workflow/)
* [Blog](https://deis.com/blog/)

[Deis Workflow]: https://github.com/deis/workflow#readme
