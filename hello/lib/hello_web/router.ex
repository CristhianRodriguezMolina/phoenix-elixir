defmodule HelloWeb.Router do
  use HelloWeb, :router

  # Prepares routes which render requests for a browser
  pipeline :browser do
    plug(:accepts, ["html", "text"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {HelloWeb.LayoutView, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(HelloWeb.Plugs.Locale, "en")
    # plug(OurAuth)
    plug(:put_user_token)
    plug(:fetch_current_user)
    plug(:fetch_current_cart)
  end

  # Prepares for routes chich produce data for an api
  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :review_checks do
    # Pluging the browser pipeline
    plug(:browser)
    # plug(:ensure_authenticated_user)
    # plug(:ensure_user_owns_review)
  end

  # Function plugs -------------------

  defp put_user_token(conn, _) do
    if current_user = conn.assigns[:current_user] do
      token = Phoenix.Token.sign(conn, "user socket", current_user.id)
      assign(conn, :user_token, token)
    else
      token = Phoenix.Token.sign(conn, "user socket", "test token")
      assign(conn, :user_token, token)
      # conn
    end
  end

  defp fetch_current_user(conn, _) do
    if user_uuid = get_session(conn, :current_uuid) do
      assign(conn, :current_uuid, user_uuid)
    else
      new_uuid = Ecto.UUID.generate()

      conn
      |> assign(:current_uuid, new_uuid)
      |> put_session(:current_uuid, new_uuid)
    end
  end

  alias Hello.ShoppingCart

  # Fetch the current cart of the user and pass it to the assigns
  def fetch_current_cart(conn, _opts) do
    if cart = ShoppingCart.get_cart_by_user_uuid(conn.assigns.current_uuid) do
      assign(conn, :cart, cart)
    else
      {:ok, new_cart} = ShoppingCart.create_cart(conn.assigns.current_uuid)
      assign(conn, :cart, new_cart)
    end
  end

  # SCOPES -------------

  scope "/", HelloWeb do
    # This function links this scope to the :browser pipelines
    pipe_through(:browser)

    # Page routes
    get("/", PageController, :index)
    get("/show", PageController, :show)
    get("/test", PageController, :test)

    # The :index atom points to the controller action `index`
    get("/hello", HelloController, :index)

    # The :show atom points to the controller action `show`
    get("/hello/:messenger", HelloController, :show)

    get("/cart", CartController, :show)
    put("/cart", CartController, :update)

    # RESOURCES --------

    resources("/orders", OrderController, only: [:create, :show])

    # Product resources
    resources("/products", ProductController)

    # Cart item resources
    resources("/cart_items", CartItemController, only: [:create, :delete])

    # This will create the standard matrix of HTTP verbs, paths, and controller actions
    resources("/users", UserController)
    # To get only a read-only resource we have to specify the actions
    resources("/posts", PostController, only: [:index, :show])
    # Or if we dont want a delete opcion we cant except it
    resources("/comments", CommentController, except: [:delete])

    # Nested resources representing a many_to_one relationship between post and users
    resources "/users", UserController do
      resources("/posts", PostController)
    end
  end

  scope "/reviews", HelloWeb do
    pipe_through(:review_checks)

    # Reviews for common users
    resources("/", ReviewController)
  end

  # Scopping the admin routes (The `as: :admin` gives a different helper for admin reviews and user ones)
  scope "/admin", HelloWeb.Admin, as: :admin do
    # This function links this scope to the :browser pipelines
    pipe_through(:browser)

    # Reviews for admins
    resources("/images", ImageController)
    resources("/reviews", ReviewController)
    resources("/users", UserController)
  end

  # Scopping by versions
  scope "/api", HelloWeb.Api, as: :api do
    # This function links this scope to the :api pipelines
    pipe_through(:api)

    # Sopping for a version 1 of the project
    scope "/v1", V1, as: :v1 do
      resources("/images", ImageController)
      resources("/reviews", ReviewController)
      resources("/users", UserController)
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelloWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through(:browser)
      live_dashboard("/dashboard", metrics: HelloWeb.Telemetry)
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through(:browser)

      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end
end
