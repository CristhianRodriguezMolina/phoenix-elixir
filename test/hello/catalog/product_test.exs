defmodule Hello.Catalog.ProductTest do
  use Hello.DataCase, async: true
  alias Hello.Catalog.Product

  test "title must be at least two characters long" do
    changeset = Product.changeset(%Product{}, %{title: "I"})
    assert %{title: ["should be at least 2 character(s)"]} = errors_on(changeset)
  end
end
