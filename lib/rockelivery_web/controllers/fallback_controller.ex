defmodule RockeliveryWeb.FallbackController do
  use RockeliveryWeb, :controller

  alias RockeliveryWeb.ErrorView

  def call(conn, {:error, reason}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("404.json", result: reason)
  end
end
