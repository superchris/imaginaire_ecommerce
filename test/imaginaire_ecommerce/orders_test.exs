defmodule ImaginaireEcommerce.OrdersTest do
  use ImaginaireEcommerce.DataCase

  alias ImaginaireEcommerce.Orders

  describe "orders" do
    alias ImaginaireEcommerce.Orders.Order

    import ImaginaireEcommerce.OrdersFixtures

    @invalid_attrs %{total: nil, customer: nil, line_items: nil}

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Orders.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Orders.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      valid_attrs = %{total: 42, customer: "some customer", line_items: []}

      assert {:ok, %Order{} = order} = Orders.create_order(valid_attrs)
      assert order.total == 42
      assert order.customer == "some customer"
      assert order.line_items == []
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      update_attrs = %{total: 43, customer: "some updated customer", line_items: []}

      assert {:ok, %Order{} = order} = Orders.update_order(order, update_attrs)
      assert order.total == 43
      assert order.customer == "some updated customer"
      assert order.line_items == []
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_order(order, @invalid_attrs)
      assert order == Orders.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Orders.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end
  end
end
