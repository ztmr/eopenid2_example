%% Hackish experiment with OpenID 2.0
%% Not intended for any serious use!
%%
%% (Especially because of no real supervision and
%% temporary on_load/register hacks.)
-module (openid_auth).
-compile (export_all).
-on_load (start/0).

%% Aleppo has some problems with include_lib and
%% does not take care about erl_opts.i values from
%% rebar.config. That's the reason why we address
%% the include file with "deps/openid/include" prefix.
-include ("deps/openid/include/openid.hrl").

-define (OPENID_SERVER_NAME, openid_server).

start () -> init (), service (openid_server).

init () ->
  [ application:start (X)
    || X <- [ crypto, public_key, ssl, sasl, inets, ibrowse ] ].

service (ServiceName) ->
  Srv = ?OPENID_SERVER_NAME,
  case lists:member (Srv, registered ()) of
    false -> {ok, Pid} = gen_server:start (openid_srv, start_link, [Srv]),
             register (Srv, Pid), %% Why won't it register automatically?
             ok;
    true  -> ok
  end.

login_url (Realm, Uri, Session, Identity) ->
  Srv = ?OPENID_SERVER_NAME,
  case gen_server:call (Srv, {prepare, Session, Identity, true}) of
    {ok, AuthReq}      -> openid:authentication_url (AuthReq, Uri, Realm);
    {error, _} = Error -> Error;
    Error              -> {error, Error}
  end.

verify (Uri, Session, LoginFormData) ->
  Srv = ?OPENID_SERVER_NAME,
  gen_server:call (Srv, {verify, Session, Uri, LoginFormData}).

