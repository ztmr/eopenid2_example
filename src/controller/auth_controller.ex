defmodule Eopenid2Example.AuthController do
  use Boss.WebController

  def realm do "http://www.example.org/" end
  def myuri do "http://localhost:8001/auth/verify" end

  get :index, [] do
    {:ok, []}
  end

  post :index, [] do
    id = gpp(req, "openid_identity")
    res = :openid_auth.login_url(realm, myuri, session_id, id)
    case res do
      {:error, whatever} -> {:ok, [{:identity, id},
                                   {:error, "Discovery failed!"}]}
      auth_uri           -> {:ok, [{:identity, id}, {:auth_uri, auth_uri}]}
    end
  end

  get :verify, [] do
    res = :openid_auth.verify(myuri, session_id, req.query_params)
    case res do
      {:ok, whatever} -> {:redirect, myuri}
      whatever_else   -> {:render_other, [{:action, "index"}],
                          [{:error, "Authentication failed!"}]}
    end
  end

  def gpp(r, x) do  # Get POST param
    r.post_param(binary_to_list(x))
  end
end

