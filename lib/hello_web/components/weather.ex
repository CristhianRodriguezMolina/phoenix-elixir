defmodule HelloWeb.Weather do
  use Phoenix.Component

  def city(assigns) do
    ~H"""
    The chosen city is: <%= @name %>.
    """
  end

  def country(assigns) do
    ~H"""
    The chosen country is: <%= @name %>.
    """
  end
end
