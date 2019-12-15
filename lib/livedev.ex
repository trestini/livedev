defmodule Livedev do
  import Logger, [:info]

  def start do
    Supervisor.start_link([
      {Task, fn ->
        Logger.info "Starting Livedev"
        socket = Livedev.Core.init_default_setup
        Livedev.Core.watch(socket)
      end}
    ], strategy: :one_for_one)
  end

end
