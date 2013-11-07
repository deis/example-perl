# Perl Quick Start Guide

This guide will walk you through deploying a Perl application on Deis.

## Prerequisites

* A [User Account](http://docs.deis.io/en/latest/client/register/) on a [Deis Controller](http://docs.deis.io/en/latest/terms/controller/).
* A [Deis Formation](http://docs.deis.io/en/latest/gettingstarted/concepts/#formations) that is ready to host applications

If you do not yet have a controller or a Deis formation, please review the [Deis installation](http://docs.deis.io/en/latest/installation/) instructions.

## Setup your workstation

* Install [RubyGems](http://rubygems.org/pages/download) to get the `gem` command on your workstation
* Install [Foreman](http://ddollar.github.com/foreman/) with `gem install foreman`
* Install [Perl](http://www.perl.org/get.html) (we still recommend perl5 for library compatibility)

## Clone your Application

If you want to use an existing application, no problem.  You can also use the Deis sample application located at <https://github.com/opdemand/example-perl>.  Clone the example application to your local workstation:

    $ git clone https://github.com/opdemand/example-perl.git
    $ cd example-perl

## Prepare your Application

To use a Perl application with Deis, you will need to conform to 3 basic requirements:

 1. Use [Cpanfile](https://github.com/miyagawa/cpanfile) to manage dependencies
 2. Use [Foreman](http://ddollar.github.com/foreman/) to manage processes
 3. Use [Environment Variables](https://help.ubuntu.com/community/EnvironmentVariables) to manage configuration inside your application

If you're deploying the example application, it already conforms to these requirements.

#### 1. Use Pip to manage dependencies

Cpanfile requires that you explicitly declare your dependencies using a [cpanfile](https://github.com/miyagawa/cpanfile) file. Here is a very basic example:

	requires 'Plack' => '1.0028';
	requires 'CGI::Emulate::PSGI' => '0.15';
	requires 'CGI::Compile' => '0.16';

Dependencies are then automatically installed when you run `plackup`.

#### 2. Use Foreman to manage processes

Deis relies on a [Foreman](http://ddollar.github.com/foreman/) `Procfile` that lives in the root of your repository.  This is where you define the command(s) used to run your application.  Here is an example `Procfile`:

    web: plackup --port $PORT ./app.psgi

This tells Deis to run `web` workers using the command `plackup --port $PORT ./app.psgi`. You can test this locally by running `foreman start`.

	$ foreman start
	15:55:03 web.1  | started with pid 63629
	15:55:03 web.1  | HTTP::Server::PSGI: Accepting connections at http://0:5000/

You should now be able to access your application locally at <http://localhost:5000>.

#### 3. Use Environment Variables to manage configuration

Deis uses environment variables to manage your application's configuration. For example, your application listener must use the value of the `PORT` environment variable. The following code snippet demonstrates how this can work inside your application:

    [ sprintf('Port is %s', $ENV{'PORT'} || '5000') ],

## Create a new Application

Per the prerequisites, we assume you have access to an existing Deis formation. If not, please review the Deis [installation instuctions](http://docs.deis.io/en/latest/gettingstarted/installation/).

Use the following command to create an application on an existing Deis formation.

    $ deis create --formation=<formationName> --id=<appName>
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

	$ curl -s http://yourapp.yourformation.com
	Powered by Deis
	$ deis config:set POWERED_BY=Perl
	=== <appName>
	POWERED_BY: Perl
	$ curl -s http://yourapp.yourformation.com
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
* [GitHub Project](https://github.com/opdemand/deis)
* [Documentation](http://docs.deis.io/)
* [Blog](http://deis.io/blog/)
