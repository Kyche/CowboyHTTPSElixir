defmodule CowboyElixirHTTPS do

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
            worker(__MODULE__, [], function: :run)
              ]

    opts = [strategy: :one_for_one, name: CowboyElixirHTTPS.Supervisor]
        Supervisor.start_link(children, opts)
  end

  def run do
        routes = [
                {"/", CowboyElixirHTTPS.Handler, []}
                  ]

    dispatch = :cowboy_router.compile([{:_, routes}])

    priv_dir= Path.relative_to_cwd("priv")

    opts_ssl = [{:port, 8000},
            {:certfile, priv_dir <> "/ssl/server.crt"},
            {:keyfile, priv_dir <>   "/ssl/server.key"}]

    opts = [{:port, 8001}]

    env = [dispatch: dispatch]

    {:ok, _pid1} = :cowboy.start_https(:https, 100, opts_ssl, [env: env])
    {:ok, _pid2} = :cowboy.start_http(:http, 100, opts, [env: env])
    end

end
