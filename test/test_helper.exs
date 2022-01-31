Ecto.Adapters.SQL.Sandbox.mode(Rockelivery.Repo, :manual)

Mox.defmock(Rockelivery.ViaCepMock, for: Rockelivery.ViaCep.Behaviour)

Application.put_env(:rockelivery, :viacep, Rockelivery.ViaCepMock)

ExUnit.start()
