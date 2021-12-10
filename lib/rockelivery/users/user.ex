defmodule Rockelivery.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogerate: true}
  @required_fields [
    :address,
    :age,
    :zipcode,
    :document,
    :email,
    :password,
    :name
  ]

  schema "users" do
    field :address, :string
    field :age, :integer
    field :zipcode, :string
    field :document, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :name, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:password, min: 6)
    |> validate_length(:zipcode, is: 8)
    |> validate_length(:document, is: 11)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:document])
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    changeset
    |> change(Pbkdf2.add_hash(password))
    |> change(%{password: nil})
  end

  defp put_password_hash(changeset), do: changeset
end
