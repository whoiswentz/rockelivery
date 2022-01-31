defmodule Rockelivery.ViaCepTest do
  use ExUnit.Case

  alias Rockelivery.ViaCep

  describe "get_zipcode/2" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "when there is a valid zipcode, return his info", %{bypass: bypass} do
      zipcode = "01001000"

      url = endpoint_url(bypass.port)
      body = ~s({
      			"cep": "01001-000",
      			"logradouro": "Praça da Sé",
      			"complemento": "lado ímpar",
      			"bairro": "Sé",
      			"localidade": "São Paulo",
      			"uf": "SP",
      			"ibge": "3550308",
      			"gia": "1004",
      			"ddd": "11",
      			"siafi": "7107"
    		})

      Bypass.expect(bypass, "GET", "#{zipcode}/json", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(200, body)
      end)

      response = ViaCep.get_zipcode(url, zipcode)

      expected_response =
        {:ok,
         %{
           "cep" => "01001-000",
           "logradouro" => "Praça da Sé",
           "complemento" => "lado ímpar",
           "bairro" => "Sé",
           "localidade" => "São Paulo",
           "uf" => "SP",
           "ibge" => "3550308",
           "gia" => "1004",
           "ddd" => "11",
           "siafi" => "7107"
         }}

      assert response == expected_response
    end

    test "when there is an invalid zipcode, returns an error", %{bypass: bypass} do
      zipcode = "123"

      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, "GET", "#{zipcode}/json", fn conn ->
        Plug.Conn.resp(conn, 400, "")
      end)

      response = ViaCep.get_zipcode(url, zipcode)

      assert response ==
               {:error, %Rockelivery.Error{result: "Invalid zipcode", status: :bad_request}}
    end

    test "when the zipcode was not found, returns an error", %{bypass: bypass} do
      zipcode = "00000000"

      url = endpoint_url(bypass.port)
      body = ~s({"error": true})

      Bypass.expect(bypass, "GET", "#{zipcode}/json", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(200, body)
      end)

      response = ViaCep.get_zipcode(url, zipcode)

      expected_response =
        {:error, %Rockelivery.Error{result: "Zipcode not found", status: :not_found}}

      assert response == expected_response
    end

    test "when theres an internal error from VieCep, returns an error", %{bypass: bypass} do
      zipcode = "00000000"

      url = endpoint_url(bypass.port)

      Bypass.down(bypass)

      response = ViaCep.get_zipcode(url, zipcode)

      expected_response =
        {:error, %Rockelivery.Error{result: :econnrefused, status: :bad_request}}

      assert response == expected_response
    end
  end

  defp endpoint_url(port), do: "http://localhost:#{port}/"
end
