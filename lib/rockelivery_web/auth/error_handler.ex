defmodule RockeliveryWeb.Auth.ErrorHandler do
  alias Guardian.Plug.ErrorHandler
  alias Plug.Conn

  @behaviour ErrorHandler

  @impl ErrorHandler
  def auth_error(conn, {error, _reason}, _opts) do
    body = Jason.encode!(%{message: to_string(error)})

    conn
    |> Conn.put_resp_header("content-type", "application/json")
    |> Conn.resp(:unauthorized, body)
    |> Conn.send_resp()
  end
end
