defmodule TextClient.Player do
  alias TextClient.{State, Summary, Prompter, Mover}

  def play(%State{tally: %{game_state: :won}}) do
    exit_message "You won"
  end

  def play(%State{tally: %{game_state: :lost}}) do
    exit_message "You lost"
  end

  def play(game = %State{tally: %{game_state: :good_guess}}) do
    continue_message(game, "Good guess")
  end

  def play(game = %State{tally: %{game_state: :bad_guess}}) do
    continue_message(game, "Bad guess")
  end

  def play(game = %State{tally: %{game_state: :already_used}}) do
    continue_message(game, "Already used that letter")
  end

  def play(game), do: continue(game)

  defp continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.move()
    |> play()
  end

  defp continue_message(game, msg) do
    IO.puts msg
    continue(game)
  end

  defp exit_message(msg) do
    IO.puts msg
    exit(:normal)
  end
end
