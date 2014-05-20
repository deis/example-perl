# Perl Quick Start Guide

This guide will walk you through deploying a Perl application on Deis.

## Usage

    $ deis create
    Creating application... done, created upbeat-villager
    Git remote deis added
    $ git push deis master
    Counting objects: 31, done.
    Delta compression using up to 8 threads.
    Compressing objects: 100% (16/16), done.
    Writing objects: 100% (31/31), 7.35 KiB | 0 bytes/s, done.
    Total 31 (delta 10), reused 31 (delta 10)
    -----> Perl/PSGI app detected
    -----> Bootstrapping cpanm
           Successfully installed App-cpanminus-1.7004
           1 distribution installed
    -----> Installing dependencies
           Successfully installed Mojolicious-4.99
           1 distribution installed
    -----> Installing Starman
           Successfully installed Test-Harness-3.30
           Successfully installed ExtUtils-Helpers-0.022
           Successfully installed ExtUtils-Config-0.007
           Successfully installed ExtUtils-InstallPaths-0.010
           Successfully installed Module-Build-Tiny-0.036
           Successfully installed File-ShareDir-Install-0.08
           Successfully installed ExtUtils-MakeMaker-6.98 (upgraded from 6.57_05)
           Successfully installed Test-Requires-0.07
           Successfully installed Stream-Buffered-0.02
           Successfully installed Test-SharedFork-0.24
           Successfully installed Test-TCP-2.02
           Successfully installed Class-Inspector-1.28
           Successfully installed File-ShareDir-1.102
           Successfully installed HTTP-Tiny-0.043 (upgraded from 0.012)
           Successfully installed Hash-MultiValue-0.15
           Successfully installed Try-Tiny-0.22
           Successfully installed URI-1.60
           Successfully installed Devel-StackTrace-1.32
           Successfully installed POSIX-strftime-Compiler-0.31
           Successfully installed Apache-LogFormat-Compiler-0.30
           Successfully installed LWP-MediaTypes-6.02
           Successfully installed Encode-Locale-1.03
           Successfully installed IO-HTML-1.00
           Successfully installed HTTP-Date-6.02
           Successfully installed HTTP-Message-6.06
           Successfully installed HTTP-Body-1.19
           Successfully installed Filesys-Notify-Simple-0.12
           Successfully installed Devel-StackTrace-AsHTML-0.14
           Successfully installed Plack-1.0030
           Successfully installed Net-Server-2.008
           Successfully installed HTTP-Parser-XS-0.16
           Successfully installed Data-Dump-1.22
           Successfully installed Starman-0.4009
           33 distributions installed
    -----> Discovering process types
           Default process types for Perl/PSGI -> web
    -----> Compiled slug size is 2.1M
    -----> Building Docker image
    Uploading context 2.168 MB
    Uploading context
    Step 0 : FROM deis/slugrunner
     ---> 5567a808891d
    Step 1 : RUN mkdir -p /app
     ---> Using cache
     ---> 928145890a08
    Step 2 : ADD slug.tgz /app
     ---> ebd37e44d6df
    Removing intermediate container 6a425737c3af
    Step 3 : ENTRYPOINT ["/runner/init"]
     ---> Running in 530c9f5b931a
     ---> 73bd9513ee35
    Removing intermediate container 530c9f5b931a
    Successfully built 73bd9513ee35
    -----> Pushing image to private registry

           Launching... done, v2

    -----> upbeat-villager deployed to Deis
           http://upbeat-villager.local.deisapp.com

           To learn more, use `deis help` or visit http://deis.io

    To ssh://git@local.deisapp.com:2222/upbeat-villager.git
     * [new branch]      master -> master
    $ curl http://upbeat-villager.local.deisapp.com
    Powered by Deis

## Additional Resources

* [Get Deis](http://deis.io/get-deis/)
* [GitHub Project](https://github.com/deis/deis)
* [Documentation](http://docs.deis.io/)
* [Blog](http://deis.io/blog/)
