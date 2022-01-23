defmodule Rockelivery.Item do
  use Ecto.Schema
  import Ecto.Changeset

  alias Rockelivery.Order

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_fields [:item_category, :description, :price, :photo]
  @item_category [:food, :drink, :desert]

  @derive {Jason.Encoder, only: @required_fields ++ [:id]}

  schema "items" do
    field :item_category, Ecto.Enum, values: @item_category
    field :description, :string
    field :price, :decimal
    field :photo, :string

    many_to_many :orders, Order, join_through: "orders_items"

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_fields)
    |> validate_length(:description, min: 6)
    |> validate_number(:price, greater_than: 0)
  end
end
