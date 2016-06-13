defmodule CowboyElixirHTTPS.Handler do
  def init(type,req,opts) do
    case type do
      {:ssl, _} -> {:ok, req, :ssl}
      {:tcp, _} -> {:ok, req, :tcp}
    end

  end

  def handle(req, state) do
    headers = [{"content-type","text/plain"}]
    body = case state do
      :ssl -> "Hello World! (ssl)"
      :tcp -> "Hello World!"
    end

    {:ok, resp} = :cowboy_req.reply(200,headers,body,req)
    {:ok, resp, state}

  end

  def terminate(_reason,_req,_state) do
    :ok
  end
end
