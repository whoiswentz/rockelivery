defmodule Rockelivery.Users.Get do
  alias Rockelivery.{Repo, User, Error}

  def by_id(id) do
    case Repo.get(User, id) do
      %User{} = user -> {:ok, user}
      nil -> {:error, Error.user_not_found()}
    end
  end
end
