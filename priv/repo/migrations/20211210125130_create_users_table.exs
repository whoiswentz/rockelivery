defmodule Rockelivery.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :address, :string
      add :age, :integer
      add :zipcode, :string
      add :document, :string
      add :email, :string
      add :password_hash, :string
      add :name, :string

      timestamps()
    end

    create unique_index(:users, [:document])
    create unique_index(:users, [:email])
  end
end
