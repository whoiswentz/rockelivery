defmodule Rockelivery.Repo.Migrations.CreateOrdersItemsTable do
  use Ecto.Migration

  def change do
    create table(:orders_items) do
      add :item_id, references(:items, type: :binary_id)
      add :order_id, references(:orders, type: :binary_id)

      timestamps()
    end
  end
end
