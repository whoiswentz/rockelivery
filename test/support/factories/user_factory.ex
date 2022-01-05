defmodule Rockelivery.Test.Support.Factories.UserFactory do
  use ExMachina

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
end
