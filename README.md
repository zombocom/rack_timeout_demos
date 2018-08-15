# Rack Timeout Demos

Rack Timeout has settings, and it may be hard to understand what they do. Here are small example scripts that demonstrate certain behavior.

## Service Timeout

Service timeout is the time spent inside of the application. I.e. once it hits rack then the timeout value starts.

### Boot

```
$ EXAMPLE_SLEEP_TIME=2 RACK_TIMEOUT_SERVICE_TIMEOUT=1 bundle exec rackup config.ru
```

### Hit

```
$ curl localhost:9292 -I
```

### Results

When "service timeout" is set to 1 second, but the request will sleep for 2 seconds then the request will time out and an error will be raised. It looks like this:

```term
$ EXAMPLE_SLEEP_TIME=2 RACK_TIMEOUT_SERVICE_TIMEOUT=1 bundle exec rackup config.ru
⛄  2.5.1 🚀  ~/rack-timeout-demos (master)
$ EXAMPLE_SLEEP_TIME=2 RACK_TIMEOUT_SERVICE_TIMEOUT=1 bundle exec rackup config.ru
Thin web server (v1.7.2 codename Bachmanity)
Maximum connections set to 1024
Listening on localhost:9292, CTRL+C to stop
source=rack-timeout id=d7d5425c-2630-44dd-9fae-fc50920fe476 timeout=1000ms state=ready at=info
source=rack-timeout id=d7d5425c-2630-44dd-9fae-fc50920fe476 timeout=1000ms service=1002ms state=timed_out at=error
source=rack-timeout id=d7d5425c-2630-44dd-9fae-fc50920fe476 timeout=1000ms service=1002ms state=completed at=info
Rack::Timeout::RequestTimeoutError: Request ran for longer than 1000ms
  /Users/rschneeman/rack-timeout-demos/config.ru:8:in `sleep'
  /Users/rschneeman/rack-timeout-demos/config.ru:8:in `block (2 levels) in <main>'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/lock.rb:17:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-timeout-0.5.1/lib/rack/timeout/core.rb:123:in `block in call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-timeout-0.5.1/lib/rack/timeout/support/timeout.rb:19:in `timeout'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-timeout-0.5.1/lib/rack/timeout/core.rb:122:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/tempfile_reaper.rb:15:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/lint.rb:49:in `_call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/lint.rb:37:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/show_exceptions.rb:23:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/common_logger.rb:33:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/chunked.rb:54:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/content_length.rb:15:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/connection.rb:86:in `block in pre_process'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/connection.rb:84:in `catch'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/connection.rb:84:in `pre_process'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/connection.rb:53:in `process'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/connection.rb:39:in `receive_data'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/eventmachine-1.2.7/lib/eventmachine.rb:195:in `run_machine'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/eventmachine-1.2.7/lib/eventmachine.rb:195:in `run'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/backends/base.rb:73:in `start'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/server.rb:162:in `start'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/handler/thin.rb:22:in `run'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/server.rb:297:in `start'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/server.rb:148:in `start'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/bin/rackup:4:in `<top (required)>'
  /Users/rschneeman/.gem/ruby/2.5.1/bin/rackup:23:in `load'
  /Users/rschneeman/.gem/ruby/2.5.1/bin/rackup:23:in `<top (required)>'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/cli/exec.rb:74:in `load'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/cli/exec.rb:74:in `kernel_load'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/cli/exec.rb:28:in `run'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/cli.rb:424:in `exec'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/vendor/thor/lib/thor/command.rb:27:in `run'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/vendor/thor/lib/thor/invocation.rb:126:in `invoke_command'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/vendor/thor/lib/thor.rb:387:in `dispatch'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/cli.rb:27:in `dispatch'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/vendor/thor/lib/thor/base.rb:466:in `start'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/cli.rb:18:in `start'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/exe/bundle:30:in `block in <top (required)>'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/friendly_errors.rb:124:in `with_friendly_errors'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/exe/bundle:22:in `<top (required)>'
  /Users/rschneeman/.gem/ruby/2.5.1/bin/bundle:23:in `load'
  /Users/rschneeman/.gem/ruby/2.5.1/bin/bundle:23:in `<main>'
::1 - - [15/Aug/2018:09:37:48 -0500] "HEAD / HTTP/1.1" 500 129708 1.0174
```

## Wait Timeout

Wait timeout is the value that the request waits before being serviced. You may also refer to this as "queuing".

In Rack timeout another way to think of "wait timeout" is "total timeout" because by default the service timeout will be decreased so that that the total duration of the request does not exceed the wait timeout value.

### Example 1 - Wait Timeout causes Service Request tiemout

#### Boot example 1

```
$ RACK_TIMEOUT_WAIT_TIMEOUT=1 EXAMPLE_SLEEP_TIME=2 bundle exec rackup config.ru
```

#### Hit example 1

```
$ curl localhost:9292 -I -X GET --header "X-Request-Start: t=$(ruby -e 'puts Time.now.to_f.round(3)')"
```

To trigger the "wait" timeout the "X-Request-Start" header has to be present. This is unix epoch time in miliseconds with a precision of 3 decimal places. This value usually not sent by a client but rather is added by a routing layer, for example by Heroku's router.

#### Results example 1

The request is not queued, you can see that it "waits" roughly 19 ms before the rack tiemout middleware kicks in. After this the service timeout value will be ignored and instead it will be "wait_timeout - time waited". In this case the wait timeout is 1 second (1000ms) and the time waited is 19ms. So the service timeout fires after 981ms.

```term
⛄  2.5.1 🚀  ~/rack-timeout-demos (master)
$ RACK_TIMEOUT_WAIT_TIMEOUT=1 EXAMPLE_SLEEP_TIME=2 bundle exec rackup config.ru
Thin web server (v1.7.2 codename Bachmanity)
Maximum connections set to 1024
Listening on localhost:9292, CTRL+C to stop
source=rack-timeout id=62b9d0a0-971c-4b6b-bda1-1e9ab920b423 wait=19ms timeout=981ms state=ready at=info
source=rack-timeout id=62b9d0a0-971c-4b6b-bda1-1e9ab920b423 wait=19ms timeout=981ms service=982ms state=timed_out at=error
source=rack-timeout id=62b9d0a0-971c-4b6b-bda1-1e9ab920b423 wait=19ms timeout=981ms service=983ms state=completed at=info
Rack::Timeout::RequestTimeoutError: Request waited 19ms, then ran for longer than 981ms
  /Users/rschneeman/rack-timeout-demos/config.ru:8:in `sleep'
  /Users/rschneeman/rack-timeout-demos/config.ru:8:in `block (2 levels) in <main>'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/lock.rb:17:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-timeout-0.5.1/lib/rack/timeout/core.rb:123:in `block in call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-timeout-0.5.1/lib/rack/timeout/support/timeout.rb:19:in `timeout'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-timeout-0.5.1/lib/rack/timeout/core.rb:122:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/tempfile_reaper.rb:15:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/lint.rb:49:in `_call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/lint.rb:37:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/show_exceptions.rb:23:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/common_logger.rb:33:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/chunked.rb:54:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/content_length.rb:15:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/connection.rb:86:in `block in pre_process'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/connection.rb:84:in `catch'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/connection.rb:84:in `pre_process'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/connection.rb:53:in `process'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/connection.rb:39:in `receive_data'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/eventmachine-1.2.7/lib/eventmachine.rb:195:in `run_machine'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/eventmachine-1.2.7/lib/eventmachine.rb:195:in `run'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/backends/base.rb:73:in `start'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/server.rb:162:in `start'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/handler/thin.rb:22:in `run'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/server.rb:297:in `start'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/server.rb:148:in `start'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/bin/rackup:4:in `<top (required)>'
  /Users/rschneeman/.gem/ruby/2.5.1/bin/rackup:23:in `load'
  /Users/rschneeman/.gem/ruby/2.5.1/bin/rackup:23:in `<top (required)>'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/cli/exec.rb:74:in `load'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/cli/exec.rb:74:in `kernel_load'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/cli/exec.rb:28:in `run'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/cli.rb:424:in `exec'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/vendor/thor/lib/thor/command.rb:27:in `run'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/vendor/thor/lib/thor/invocation.rb:126:in `invoke_command'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/vendor/thor/lib/thor.rb:387:in `dispatch'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/cli.rb:27:in `dispatch'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/vendor/thor/lib/thor/base.rb:466:in `start'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/cli.rb:18:in `start'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/exe/bundle:30:in `block in <top (required)>'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/friendly_errors.rb:124:in `with_friendly_errors'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/exe/bundle:22:in `<top (required)>'
  /Users/rschneeman/.gem/ruby/2.5.1/bin/bundle:23:in `load'
  /Users/rschneeman/.gem/ruby/2.5.1/bin/bundle:23:in `<main>'
::1 - - [15/Aug/2018:09:40:15 -0500] "GET / HTTP/1.1" 500 130200 1.0015
```

### Example 2 - Queuing causes Wait Timeout

We will force a request to "queue" by sending three requests to a server incapable of processing more than one request at a time.

In this case the first request should pass because it completes in less time than the "wait timeout". The second request should fail in the same way that our previous example did i.e. it passes the "wait" stage, and then runs out of time while being serviced.

Finally the third request never even has a chance to be serviced and is killed right away.

#### Boot example 2

```
$ RACK_TIMEOUT_WAIT_TIMEOUT=2 EXAMPLE_SLEEP_TIME=1 bundle exec rackup config.ru
```

#### Hit example 2

In this case we will make three concurrent requests, the single `&` tells bash to run each of the commands at the same time. Since our server is single threaded (thin) it only process one request at a time. The first request will return a success and the second and third will fail, but for different reasons.

```
$ curl localhost:9292 -I -X GET --header "X-Request-Start: t=$(ruby -e 'puts Time.now.to_f.round(3)')"
& curl localhost:9292 -I -X GET --header "X-Request-Start: t=$(ruby -e 'puts Time.now.to_f.round(3)')" & curl localhost:9292 -I -X GET --header "X-Request-Start: t=$(ruby -e 'puts Time.now.to_f.round(3)')"
```

#### Results example 2

You can see that there are three requests but only two failures. The results from posted after the server. The last request fails with error "Request older than 2000ms".

Note: Since we're playing with concurrency your results might be slightly different than mine. Some times the second request will randomly pass, the third request should always fail.

```
⛄  2.5.1 🚀  ~/rack-timeout-demos (master)
$ RACK_TIMEOUT_WAIT_TIMEOUT=2 EXAMPLE_SLEEP_TIME=1 bundle exec rackup config.ru
Thin web server (v1.7.2 codename Bachmanity)
Maximum connections set to 1024
Listening on localhost:9292, CTRL+C to stop
service_timeout: 15
seconds_service_left: 1.9791851163482665
info.timeout: 1.9791851163482665
source=rack-timeout id=918cb10a-0a7f-4390-a9ad-3731e8ed3420 wait=21ms timeout=1979ms state=ready at=info
source=rack-timeout id=918cb10a-0a7f-4390-a9ad-3731e8ed3420 wait=21ms timeout=1979ms service=1002ms state=completed at=info
::1 - - [15/Aug/2018:09:26:29 -0500] "GET / HTTP/1.1" 200 - 1.0026
service_timeout: 15
seconds_service_left: 0.9741081163482666
info.timeout: 0.9741081163482666
source=rack-timeout id=79d42e42-5603-4efc-94f5-de26aa63da5b wait=1026ms timeout=974ms state=ready at=info
source=rack-timeout id=79d42e42-5603-4efc-94f5-de26aa63da5b wait=1026ms timeout=974ms service=979ms state=timed_out at=error
source=rack-timeout id=79d42e42-5603-4efc-94f5-de26aa63da5b wait=1026ms timeout=974ms service=979ms state=completed at=info
Rack::Timeout::RequestTimeoutError: Request waited 1026ms, then ran for longer than 974ms
  /Users/rschneeman/rack-timeout-demos/config.ru:8:in `sleep'
  /Users/rschneeman/rack-timeout-demos/config.ru:8:in `block (2 levels) in <main>'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/lock.rb:17:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-timeout-0.5.1/lib/rack/timeout/core.rb:128:in `block in call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-timeout-0.5.1/lib/rack/timeout/support/timeout.rb:19:in `timeout'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-timeout-0.5.1/lib/rack/timeout/core.rb:127:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/tempfile_reaper.rb:15:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/lint.rb:49:in `_call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/lint.rb:37:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/show_exceptions.rb:23:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/common_logger.rb:33:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/chunked.rb:54:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/content_length.rb:15:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/connection.rb:86:in `block in pre_process'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/connection.rb:84:in `catch'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/connection.rb:84:in `pre_process'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/connection.rb:53:in `process'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/connection.rb:39:in `receive_data'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/eventmachine-1.2.7/lib/eventmachine.rb:195:in `run_machine'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/eventmachine-1.2.7/lib/eventmachine.rb:195:in `run'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/backends/base.rb:73:in `start'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/server.rb:162:in `start'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/handler/thin.rb:22:in `run'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/server.rb:297:in `start'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/server.rb:148:in `start'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/bin/rackup:4:in `<top (required)>'
  /Users/rschneeman/.gem/ruby/2.5.1/bin/rackup:23:in `load'
  /Users/rschneeman/.gem/ruby/2.5.1/bin/rackup:23:in `<top (required)>'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/cli/exec.rb:74:in `load'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/cli/exec.rb:74:in `kernel_load'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/cli/exec.rb:28:in `run'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/cli.rb:424:in `exec'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/vendor/thor/lib/thor/command.rb:27:in `run'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/vendor/thor/lib/thor/invocation.rb:126:in `invoke_command'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/vendor/thor/lib/thor.rb:387:in `dispatch'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/cli.rb:27:in `dispatch'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/vendor/thor/lib/thor/base.rb:466:in `start'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/cli.rb:18:in `start'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/exe/bundle:30:in `block in <top (required)>'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/friendly_errors.rb:124:in `with_friendly_errors'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/exe/bundle:22:in `<top (required)>'
  /Users/rschneeman/.gem/ruby/2.5.1/bin/bundle:23:in `load'
  /Users/rschneeman/.gem/ruby/2.5.1/bin/bundle:23:in `<main>'
::1 - - [15/Aug/2018:09:26:30 -0500] "GET / HTTP/1.1" 500 142725 1.0018
source=rack-timeout id=030328d4-1ab0-425b-82bb-5b266e4c58cd wait=2026ms timeout=2000ms state=expired at=error
Rack::Timeout::RequestExpiryError: Request older than 2000ms.
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-timeout-0.5.1/lib/rack/timeout/core.rb:96:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/tempfile_reaper.rb:15:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/lint.rb:49:in `_call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/lint.rb:37:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/show_exceptions.rb:23:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/common_logger.rb:33:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/chunked.rb:54:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/content_length.rb:15:in `call'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/connection.rb:86:in `block in pre_process'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/connection.rb:84:in `catch'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/connection.rb:84:in `pre_process'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/connection.rb:53:in `process'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/connection.rb:39:in `receive_data'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/eventmachine-1.2.7/lib/eventmachine.rb:195:in `run_machine'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/eventmachine-1.2.7/lib/eventmachine.rb:195:in `run'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/backends/base.rb:73:in `start'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/thin-1.7.2/lib/thin/server.rb:162:in `start'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/handler/thin.rb:22:in `run'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/server.rb:297:in `start'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/lib/rack/server.rb:148:in `start'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/rack-2.0.5/bin/rackup:4:in `<top (required)>'
  /Users/rschneeman/.gem/ruby/2.5.1/bin/rackup:23:in `load'
  /Users/rschneeman/.gem/ruby/2.5.1/bin/rackup:23:in `<top (required)>'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/cli/exec.rb:74:in `load'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/cli/exec.rb:74:in `kernel_load'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/cli/exec.rb:28:in `run'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/cli.rb:424:in `exec'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/vendor/thor/lib/thor/command.rb:27:in `run'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/vendor/thor/lib/thor/invocation.rb:126:in `invoke_command'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/vendor/thor/lib/thor.rb:387:in `dispatch'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/cli.rb:27:in `dispatch'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/vendor/thor/lib/thor/base.rb:466:in `start'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/cli.rb:18:in `start'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/exe/bundle:30:in `block in <top (required)>'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/lib/bundler/friendly_errors.rb:124:in `with_friendly_errors'
  /Users/rschneeman/.gem/ruby/2.5.1/gems/bundler-1.16.2/exe/bundle:22:in `<top (required)>'
  /Users/rschneeman/.gem/ruby/2.5.1/bin/bundle:23:in `load'
  /Users/rschneeman/.gem/ruby/2.5.1/bin/bundle:23:in `<main>'
::1 - - [15/Aug/2018:09:26:30 -0500] "GET / HTTP/1.1" 500 139051 0.0142
```


Curl results:

```
$ curl localhost:9292 -I -X GET --header "X-Request-Start: t=$(ruby -e 'puts Time.now.to_f.round(3)')" & curl localhost:9292 -I -X GET --header "X-Request-Start: t=$(ruby -e 'puts Time.now.to_f.round(3)')" & curl localhost:9292 -I -X GET --header "X-Request-Start: t=$(ruby -e 'puts Time.now.to_f.round(3)')"
[1] 33702
[2] 33703
HTTP/1.1 200 OK
Content-Type: text/html
Transfer-Encoding: chunked
Connection: close
Server: thin

HTTP/1.1 500 Internal Server Error
Content-Type: text/html
Content-Length: 142725
Connection: keep-alive
Server: thin

HTTP/1.1 500 Internal Server Error
Content-Type: text/html
Content-Length: 139051
Connection: keep-alive
Server: thin
```

Note that the first request to return is a success (200) while the second and third request is a failure (500).


## Wait Overtime

Disabled by default. When enabled and a reques has a body (for example a post with a json blob) then this does something different. Here's the docs https://github.com/heroku/rack-timeout/blob/master/doc/settings.md#wait-overtime.