defmodule TodoBackend.List.Lists do

  alias TodoBackend.Repo
  alias TodoBackend.List

  @doc """
  Lists all lists.
  """
  def list_lists do
    Repo.all(List)
  end

  @doc """
  Gets a single list by ID.
  """
  def get_list!(id) do
    Repo.get!(List, id)
  end

  @doc """
  Creates a list.
  """
  def create_list(attrs \\ %{}) do
    %List{}
    |> List.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a list.
  """
  def update_list(%List{} = list, attrs) do
    list
    |> List.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a list.
  """
  def delete_list(%List{} = list) do
    Repo.delete(list)
  end
end
