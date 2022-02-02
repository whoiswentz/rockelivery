defmodule Rockelivery.Orders.Report do
  import Ecto.Query

  alias Rockelivery.{Order, Repo, Item}
  alias Rockelivery.Orders.TotalPrice

  @default_block_size 500

  def create(filename \\ "report.csv") do
    query = from(order in Order, order_by: order.user_id)

    {:ok, lines} =
      Repo.transaction(fn ->
        query
        |> Repo.stream(max_rows: @default_block_size)
        |> Stream.chunk_every(@default_block_size)
        |> Stream.flat_map(&Repo.preload(&1, :items))
        |> Enum.map(&parse_line/1)
      end)

    File.write(filename, lines)
  end

  defp parse_line(%Order{user_id: user_id, payment_method: payment_method, items: items}) do
    items_string = Enum.map(items, &item_string/1)
    total_price = TotalPrice.calculate(items)

    "#{user_id},#{payment_method},#{items_string}#{total_price}"
  end

  defp item_string(%Item{item_category: item_category, description: description, price: price}) do
    "#{item_category},#{description},#{price},"
  end
end
