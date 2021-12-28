defmodule RockeliveryWeb.UserView do
  use RockeliveryWeb, :view

  alias Rockelivery.User

  def render("create.json", %{user: %User{} = user}) do
    user
  end

  def render("show.json", %{user: %User{} = user}) do
    user
  end
end
