defmodule Hello.Repo.Migrations.CreateProductCategories do
  use Ecto.Migration

  def change do
    create table(:product_categories, primary_key: false) do
      # The delete_all function ensures that the table is deleted if the related product or category is deleted
      add(:product_id, references(:products, on_delete: :delete_all))
      add(:category_id, references(:categories, on_delete: :delete_all))
    end

    create(index(:product_categories, [:product_id]))
    create(index(:product_categories, [:category_id]))
    # To ensure a product cannot have duplicated categories
    create(unique_index(:product_categories, [:category_id, :product_id]))
  end
end
