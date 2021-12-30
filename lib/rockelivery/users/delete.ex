defmodule Rockelivery.Users.Delete do
  alias Rockelivery.{User, Repo, Error}

  def call(id) do
    case Repo.get(User, id) do
      %User{} = user -> Repo.delete(user)
      nil -> {:error, Error.user_not_found()}
    end
  end
end
