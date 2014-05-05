# Perl Quick Start Guide

This guide will walk you through deploying a Perl application on Deis.

## Create a new Application

We assume you have access to an existing Deis cluster. If not, please review the Deis [installation instuctions](http://docs.deis.io/en/latest/operations/provision-controller/).

Use the following command to create an application on an existing Deis cluster.

    $ deis create
	Creating application... done, created <appName>
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
	Scaling containers... but first, coffee!
	done in 16s
	
	=== <appName> Containers
	
	--- web: `plackup --port $PORT ./app.psgi`
	web.1 up 2013-11-04T22:06:53.492Z (dev-runtime-1)
	web.2 up 2013-11-04T22:58:34.244Z (dev-runtime-1)
	web.3 up 2013-11-04T22:58:34.258Z (dev-runtime-1)
	web.4 up 2013-11-04T22:58:34.272Z (dev-runtime-1)
	web.5 up 2013-11-04T22:58:34.288Z (dev-runtime-1)
	web.6 up 2013-11-04T22:58:34.304Z (dev-runtime-1)
	web.7 up 2013-11-04T22:58:34.322Z (dev-runtime-1)
	web.8 up 2013-11-04T22:58:34.342Z (dev-runtime-1)


## Configure your Application

Deis applications are configured using environment variables. The example application includes a special `POWERED_BY` variable to help demonstrate how you would provide application-level configuration. 

	$ curl -s http://yourapp.fqdn.com
	Powered by Deis
	$ deis config:set POWERED_BY=Perl
	=== <appName>
	POWERED_BY: Perl
	$ curl -s http://yourapp.fqdn.com
	Powered by Perl

`deis config:set` is also how you connect your application to backing services like databases, queues and caches. You can use `deis run` to execute one-off commands against your application for things like database administration, initial application setup and inspecting your container environment.

	$ deis run ls -la
	total 52
	drwxr-xr-x  6 root root 4096 Nov  4 22:57 .
	drwxr-xr-x 57 root root 4096 Nov  4 22:59 ..
	drwxr-xr-x  2 root root 4096 Nov  4 22:57 .profile.d
	-rw-r--r--  1 root root  181 Nov  4 22:57 .release
	-rw-r--r--  1 root root 1083 Nov  4 22:57 LICENSE.txt
	-rw-r--r--  1 root root   37 Nov  4 22:57 Procfile
	-rw-r--r--  1 root root 6913 Nov  4 22:57 README.md
	-rwxr-xr-x  1 root root  197 Nov  4 22:57 app.psgi
	drwxr-xr-x  2 root root 4096 Nov  4 22:57 cgi-bin
	-rw-r--r--  1 root root  106 Nov  4 22:57 cpanfile
	drwxr-xr-x  2 root root 4096 Nov  4 22:57 htdocs
	drwxrwxr-x  5 root root 4096 Nov  4 22:05 local

## Troubleshoot your Application

To view your application's log output, including any errors or stack traces, use `deis logs`.

	$ deis logs
	Nov  4 22:58:48 ip-172-31-3-111 jagged-inventor[web.8]: find: `/app/.profile.d/*.sh': No such file or directory
	Nov  4 22:58:48 ip-172-31-3-111 jagged-inventor[web.7]: HTTP::Server::PSGI: Accepting connections at http://0:10007/
	Nov  4 22:58:48 ip-172-31-3-111 jagged-inventor[web.8]: HTTP::Server::PSGI: Accepting connections at http://0:10008/

## Additional Resources

* [Get Deis](http://deis.io/get-deis/)
* [GitHub Project](https://github.com/deis/deis)
* [Documentation](http://docs.deis.io/)
* [Blog](http://deis.io/blog/)
