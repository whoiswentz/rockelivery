defmodule Rockelivery.Users.CreateTest do
  use Rockelivery.DataCase, async: true

  alias Rockelivery.{Error, User}
  alias Rockelivery.Users.Create

  import Rockelivery.Test.Support.Factories.UserFactory

  describe "call/1" do
    test "when all params are valid, returns the user" do
      params = build(:user_params)

      response = Create.call(params)

      assert {:ok, %User{id: _id, age: 29}} = response
    end

    test "when there are invalid params, returns an error" do
      params = build(:user_params, %{age: 15})

      response = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
