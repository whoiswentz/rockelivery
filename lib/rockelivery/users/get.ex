defmodule Rockelivery.Users.Get do
  alias Rockelivery.{Repo, User, Error}

  def by_id(id) do
    with {:ok, uuid} <- Ecto.UUID.cast(id),
         %User{} = user <- Repo.get(User, uuid) do
      {:ok, user}
    else
      :error -> {:error, Error.id_format_error()}
      nil -> {:error, Error.user_not_found()}
    end
  end
end
