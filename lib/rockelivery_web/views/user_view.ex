defmodule RockeliveryWeb.UserView do
  use RockeliveryWeb, :view

  alias Rockelivery.User

  def render("create.json", %{token: token, user: %User{} = user}) do
    %{token: token, user: user}
  end

  def render("show.json", %{user: %User{} = user}) do
    user
  end

  def render("sign_in.json", %{token: token}), do: %{token: token}
end
