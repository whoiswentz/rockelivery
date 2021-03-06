defmodule Rockelivery do
  @moduledoc """
  Rockelivery keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  defdelegate create_user(params), to: Rockelivery.Users.Create, as: :call
  defdelegate get_user_by_id(id), to: Rockelivery.Users.Get, as: :by_id
  defdelegate delete_user(id), to: Rockelivery.Users.Delete, as: :call
  defdelegate update_user(params), to: Rockelivery.Users.Update, as: :call

  defdelegate create_item(params), to: Rockelivery.Items.Create, as: :call

  defdelegate create_order(params), to: Rockelivery.Orders.Create, as: :call
end
