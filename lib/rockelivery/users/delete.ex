defmodule Rockelivery.Users.Delete do
  alias Rockelivery.{User, Repo, Error}

  def call(id) do
    with {:ok, uuid} <- Ecto.UUID.cast(id),
         %User{} = user <- Repo.get(User, uuid) do
      Repo.delete(user)
    else
      :error -> {:error, Error.id_format_error()}
      nil -> {:error, Error.user_not_found()}
    end
  end
end
