defmodule Rockelivery.ViaCep do
  use Tesla

  alias Rockelivery.Error

  plug Tesla.Middleware.BaseUrl, "https://viacep.com.br/ws/"
  plug Tesla.Middleware.JSON

  def get_zipcode(zipcode) do
    "#{zipcode}/json"
    |> get()
    |> handle_get()
  end

  def handle_get({:ok, %Tesla.Env{status: 200, body: %{"error" => true}}}) do
    {:error, Error.build(:not_found, "Zipcode not found")}
  end

  def handle_get({:ok, %Tesla.Env{status: 200, body: body}}) do
    {:ok, body}
  end

  def handle_get({:ok, %Tesla.Env{status: 400, body: _body}}) do
    {:error, Error.build(:bad_request, "Invalid zipcode")}
  end

  def handle_get({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end
end
