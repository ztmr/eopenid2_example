Erlang OpenID 2.0 experiment
============================
This is an experiment with ChicagoBoss and erl_openid library
with aim to get OpenID library up and working exactly as we need.

To make things more complicated, I decided to test not only OpenID
library, but also the Elixir and Jade support in ChicagoBoss :)
Since Jade seems to bring critical bugs, the original Jade template
is left abadoned and superseded by a "conventional" Django template.

OpenID experiment results
=========================
Well the library seems to work somehow, but the generated authentication
URI does not seem to be valid since at least Google and Yahoo report
errors when trying to use it.

The problem of OpenID 2.0 authentication from Erlang application is
therefore still open and we're looking for pointers what we did wrong,
what is wrong with the library, or if there is another and better option
how to do the authentication job easier.

References
==========
* [OpenID 2.0 library for Erlang (the one used in our experiment)](http://github.com/brendonh/erl_openid)
* [ChicagoBoss web framework](http://github.com/evanmiller/ChicagoBoss)
