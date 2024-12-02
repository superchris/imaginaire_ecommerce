defmodule ImaginaireEcommerce.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :customer, :string
      add :total, :integer
      add :line_items, {:array, :map}
      add :discounts, {:array, :map}

      timestamps(type: :utc_datetime)
    end
  end
end
