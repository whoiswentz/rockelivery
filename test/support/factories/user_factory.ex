defmodule Rockelivery.Test.Support.Factories.UserFactory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      address: "asdasdasdasd",
      age: 29,
      document: "12344234147",
      email: "asasd1@asdas.com",
      name: "asdasda",
      password: "123321123312",
      zipcode: "12341234"
    }
  end

  def user_params_controller_factory do
    %{
      "address" => "asdasdasdasd",
      "age" => 29,
      "document" => "12344234147",
      "email" => "asasd1@asdas.com",
      "name" => "asdasda",
      "password" => "123321123312",
      "zipcode" => "12341234"
    }
  end

  def user_factory do
    %User{
      address: "asdasdasdasd",
      age: 29,
      document: "12344234147",
      email: "asasd1@asdas.com",
      name: "asdasda",
      password: "123321123312",
      zipcode: "12341234",
      id: "2262789b-b631-4cb0-9b1a-62658e53ac95"
    }
  end
end
