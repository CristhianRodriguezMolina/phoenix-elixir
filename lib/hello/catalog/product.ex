defmodule Hello.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  # Relations
  alias Hello.Catalog.Category

  schema "products" do
    field(:description, :string)
    field(:price, :decimal)
    field(:title, :string)
    field(:views, :integer)

    # Association through the `product_categories` table
    many_to_many(:categories, Category, join_through: "product_categories", on_replace: :delete)

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:title, :description, :price, :views])
    |> validate_required([:title, :description, :price, :views])
    |> validate_length(:title, min: 2)
  end
end
