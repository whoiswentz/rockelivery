defmodule Rockelivery.Items.Create do
  alias Rockelivery.{Item, Repo, Error}

  def call(params) do
    params
    |> Item.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Item{}} = result) do
    result
  end

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
