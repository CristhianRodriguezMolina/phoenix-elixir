defmodule Mix.Tasks.Hello.Greeting do
  use Mix.Task

  @shortdoc "Sends a greeting to us from Hello Phoenix"

  @moduledoc """
  This is where we would put any long form documentation and doctests.
  """

  @impl Mix.Task
  def run(args) do
    [head | _] = args

    case head do
      "1" -> test()
      _ -> Mix.shell().info("Greetings from the Hello Phoenix Application!")
    end
  end

  # We can define other functions as needed here.

  def test() do
    Mix.shell().info("This a test mix task printed with arg = 1")
  end
end
