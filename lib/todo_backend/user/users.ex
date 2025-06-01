defmodule TodoBackend.User.Users do
  alias TodoBackend.User
  alias TodoBackend.Repo

  @doc """
  Creates a user.
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets a single user by ID.
  """
  def get_user!(id) do
    Repo.get!(User, id)
  end

  @doc """
  Gets all users..
  """
  def get_users() do
    Repo.all(User)
  end
end
