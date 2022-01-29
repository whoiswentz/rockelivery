defmodule Rockelivery.Users.Create do
  alias Rockelivery.{User, Repo, Error, ViaCep}

  def call(%{"zipcode" => zipcode} = params) do
    changeset = User.changeset(params)

    case ViaCep.get_zipcode(zipcode) do
      {:ok, _cep_info} ->
        save_user(changeset)

      {:error, _result} = error ->
        error
    end
  end

  defp save_user(changeset) do
    User.build(changeset)

    changeset
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %User{}} = result) do
    result
  end

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
