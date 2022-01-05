defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Test.Support.Factories.UserFactory

  alias Ecto.Changeset
  alias Rockelivery.User

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params)

      result = User.changeset(params)

      assert %Changeset{changes: %{name: "asdasda"}, valid?: true} = result
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = build(:user_params)

      update_params = %{zipcode: "43218765"}

      result = params |> User.changeset() |> User.changeset(update_params)

      assert %Changeset{changes: %{zipcode: "43218765"}, valid?: true} = result
    end

    test "when there are some error, returns an invalid changeset" do
      params =
        build(:user_params, %{
          age: 14,
          password: "112"
        })

      result = User.changeset(params)

      expected_result = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(result) == expected_result
    end
  end
end
