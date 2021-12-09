defmodule Hello.ShoppingCart.CartItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cart_items" do
    field(:price_when_carted, :decimal)
    field(:quantity, :integer)

    # This `belongs_to` are replacing the `cart_id` and `product_id`
    belongs_to(:cart, Hello.ShoppingCart.Cart)
    belongs_to(:product, Hello.Catalog.Product)

    timestamps()
  end

  @doc false
  def changeset(cart_item, attrs) do
    cart_item
    |> cast(attrs, [:price_when_carted, :quantity])
    |> validate_required([:price_when_carted, :quantity])
    # Validating the quantity
    |> validate_number(:quantity, greater_than_or_equal_to: 0, less_than: 100)
  end
end