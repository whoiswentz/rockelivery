defmodule Rockelivery.Users.Update do
  alias Rockelivery.{User, Repo, Error}

  def call(%{"id" => id} = params) do
    case Repo.get(User, id) do
      %User{} = user -> update(user, params)
      nil -> {:error, Error.user_not_found()}
    end
  end

  defp update(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end
