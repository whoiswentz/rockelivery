defmodule Rockelivery.ViaCep.Behaviour do
  @callback get_zipcode(String.t()) :: {:ok, map()} | {:error, Rockelivery.Error.t()}
end
