defmodule Livedev do

  def start do
    if IEx.started? do
      case Livedev.Core.init_default_setup do
        {:ok, socket} ->
          Supervisor.start_link([
            {Task, fn () ->
              Livedev.Core.watch(socket)
            end}
          ], strategy: :one_for_one)
          :ok
        {:error, reason} -> {:error, reason}
      end
    else
      {:error, :iex_not_started}
    end
  end

end
