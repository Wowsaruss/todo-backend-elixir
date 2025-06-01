defmodule TodoBackend.Board.Boards do

  alias TodoBackend.Repo
  alias TodoBackend.Board

  @doc """
  Lists all boards.
  """
  def list_boards do
    Repo.all(Board)
  end

  @doc """
  Gets a single board by ID.
  """
  def get_board!(id) do
    Repo.get!(Board, id)
  end

  @doc """
  Creates a board.
  """
  def create_board(attrs \\ %{}) do
    %Board{}
    |> Board.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a board.
  """
  def update_board(%Board{} = board, attrs) do
    board
    |> Board.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a board.
  """
  def delete_board(%Board{} = board) do
    Repo.delete(board)
  end
end
