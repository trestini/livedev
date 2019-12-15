defmodule Livedev.Core do

  def init_default_setup do
    case lookup_unix_socket() do
      %{"sockname" => path} ->
        {:ok, socket} = connect(path)
        subscribe socket
        {:ok, socket}
      {:error, reason} -> {:error, reason}
    end
  end

  def lookup_unix_socket do
    try do
      case System.cmd("watchman", ["get-sockname"]) do
        {ret, code} when code == 0 -> Poison.decode! ret
        {_, code} -> {:error, code}
      end
    rescue ErlangError -> {:error, :nowatchman}
    end
  end

  def connect(path) do
    opts = opts = [:binary, active: false, keepalive: true]
    :gen_tcp.connect({:local, path}, 0, opts)
  end

  def subscribe(socket) do
    {:ok, cwd} = File.cwd
    wmid = "#{elem(:application.which_applications |> List.first, 0)}_livedev"
    command = [
      "subscribe",
      cwd,
      wmid,
      %{
        "expression" => ["allof",
                            ["type", "f"],
                            ["suffix", "ex"]
                        ],
        "fields" => ["name", "exists", "new"]
      }
    ]

    raw = Poison.encode! command
#    https://medium.com/@hdswick/unix-domain-sockets-ipc-with-elixir-ec027f83c511
    socket
      |> :gen_tcp.send(raw <> "\n")
      |> receive_response(socket, 5000)
  end

  def watch(socket) do
    case receive_response(:ok, socket, 10_000) do
      {:ok, response} ->
        spawn fn -> handler(response) end
        watch(socket)
      {:error, :timeout} -> watch(socket)
      {:error, reason} ->
        IO.puts(:stderr, "tcp recv error: #{reason}")
        reason
    end
  end

  defp receive_response(data, socket, timeout, initial \\ <<>>)

  defp receive_response({:error, reason}, _socket, _timeout, _result) do
    {:error, reason}
  end

  defp receive_response(:ok, socket, timeout, accum) do
    with {:ok, response} <- :gen_tcp.recv(socket, 0, timeout) do
      new_result = accum <> response

      if String.ends_with?(response, "\n") do
        {:ok, response}
      else
        receive_response(:ok, socket, timeout, new_result)
      end
    end
  end


  defp handler(response) do
    event = Poison.decode! response
    files = event["files"]
      |> Enum.map(
        fn
          %{"name" => name} ->
            name
        end)
      |> Enum.reject(&String.starts_with?(&1, "deps"))
    if length(files) > 0 do
      try do
        IEx.Helpers.recompile()
      catch e -> IO.puts(:stderr, IO.inspect(e)) end
    end
  end
end
