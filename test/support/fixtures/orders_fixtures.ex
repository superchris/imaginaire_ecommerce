defmodule ImaginaireEcommerce.OrdersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ImaginaireEcommerce.Orders` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        customer: "some customer",
        line_items: [],
        total: 42
      })
      |> ImaginaireEcommerce.Orders.create_order()

    order
  end
end
