# Perl Quick Start Guide

This guide will walk you through deploying a Perl application on Deis.

## Create a new Application

We assume you have access to an existing Deis cluster. If not, please review the Deis [installation instuctions](http://docs.deis.io/en/latest/operations/provision-controller/).

Use the following command to create an application on an existing Deis cluster.

    $ deis create
	Creating application... done, created cubist-quacking
	Git remote deis added
    
If an ID is not provided, one will be auto-generated for you.

## Deploy your Application

Use `git push deis master` to deploy your application.

	$ git push deis master
	Counting objects: 8, done.
	Delta compression using up to 4 threads.
	Compressing objects: 100% (6/6), done.
	Writing objects: 100% (6/6), 3.12 KiB, done.
	Total 6 (delta 3), reused 0 (delta 0)
	       Perl/PSGI app detected
	-----> Installing dependencies
	-----> Installing Starman
	       Starman is up to date. (0.4008)

Once your application has been deployed, use `deis open` to view it in a browser. To find out more info about your application, use `deis info`.

## Scale your Application

To scale your application's [Docker](http://docker.io) containers, use `deis scale` and specify the number of containers for each process type defined in your application's `Procfile`. For example, `deis scale web=8`.

    $ deis scale web=8
    Scaling processes... but first, coffee!
    done in 8s

    === cubist-quacking Processes

    --- web:
    web.1 up (v3)
    web.2 up (v3)
    web.3 up (v3)
    web.4 up (v3)
    web.5 up (v3)
    web.6 up (v3)
    web.7 up (v3)
    web.8 up (v3)

## Configure your Application

Deis applications are configured using environment variables. The example application includes a special `POWERED_BY` variable to help demonstrate how you would provide application-level configuration. 

	$ curl -s http://cubist-quacking.fqdn.com
	Powered by Deis
	$ deis config:set POWERED_BY=Perl
	=== cubist-quacking
	POWERED_BY: Perl
	$ curl -s http://cubist-quacking.fqdn.com
	Powered by Perl

`deis config:set` is also how you connect your application to backing services like databases, queues and caches. You can use `deis run` to execute one-off commands against your application for things like database administration, initial application setup and inspecting your container environment.

	$ deis run env
    HOSTNAME=5b2a94820bbc
    POWERED_BY=Perl
    PATH=local/bin:/usr/local/bin:/usr/bin:/bin
    _=/usr/bin/env
    PWD=/app
    HOME=/app
    SHLVL=2

## Troubleshoot your Application

To view your application's log output, including any errors or stack traces, use `deis logs`.

	$ deis logs
    2014-05-05 19:47:27 172.17.8.100:38929 cubist-quacking[web.1]: 2014/05/05-19:47:27 Starman::Server (type Net::Server::PreFork) starting! pid(16)
    2014-05-05 19:47:27 172.17.8.100:38929 cubist-quacking[web.1]: Resolved [*]:5000 to [0.0.0.0]:5000, IPv4
    2014-05-05 19:47:27 172.17.8.100:38929 cubist-quacking[web.1]: Binding to TCP port 5000 on host 0.0.0.0 with IPv4
    2014-05-05 19:47:27 172.17.8.100:38929 cubist-quacking[web.1]: Setting gid to "0 0"

## Additional Resources

* [Get Deis](http://deis.io/get-deis/)
* [GitHub Project](https://github.com/deis/deis)
* [Documentation](http://docs.deis.io/)
* [Blog](http://deis.io/blog/)
