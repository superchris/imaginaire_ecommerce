defmodule ImaginaireEcommerce.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :total, :integer
    field :customer, :string

    embeds_many :line_items, LineItem do
      field :product, :string
      field :quantity, :integer
      field :price, :integer

      def changeset(order, attrs) do
        order
        |> cast(attrs, [:product, :quantity, :price])
        |> validate_required([:product, :quantity, :price])
      end
    end

    embeds_many :discounts, Discount do
      field :description, :string
      field :amount, :integer

      def changeset(order, attrs) do
        order
        |> cast(attrs, [:product, :quantity, :price])
        |> validate_required([:product, :quantity, :price])
      end
    end

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:customer, :total])
    |> cast_embed(:line_items)
    |> cast_embed(:discounts)
    |> validate_required([:customer, :total])
  end

end
