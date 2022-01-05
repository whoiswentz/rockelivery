defmodule RockeliveryWeb.UserControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  import Rockelivery.Test.Support.Factories.UserFactory

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = build(:user_params_controller)

      response =
        conn
        |> post(Routes.user_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "address" => "asdasdasdasd",
               "age" => 29,
               "document" => "12344234147",
               "email" => "asasd1@asdas.com",
               "name" => "asdasda",
               "zipcode" => "12341234",
               "id" => _id
             } = response
    end

    test "when there is some error, returns the error", %{conn: conn} do
      params =
        build(:user_params_controller, %{
          "age" => 15
        })

      response =
        conn
        |> post(Routes.user_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{
               "message" => %{
                 "age" => ["must be greater than or equal to 18"]
               }
             } = response
    end
  end

  describe "delete/2" do
    test "when there is a user with the given id, delete the user", %{conn: conn} do
      id = "2262789b-b631-4cb0-9b1a-62658e53ac95"
      insert(:user)

      response =
        conn
        |> delete(Routes.user_path(conn, :delete, id))
        |> response(:no_content)

      assert response = ""
    end
  end
end
