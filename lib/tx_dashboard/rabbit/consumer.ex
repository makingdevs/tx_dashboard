defmodule TxDashboard.Consumer do
  use GenServer
  use AMQP

  alias TxDashboard.TxWrapper

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [], [])
  end

  @exchange "amq.direct"
  @queue "receive_tx"
  @connection_url "amqp://guest:guest@localhost"

  def init(_opts) do
    {:ok, conn} = Connection.open(@connection_url)
    {:ok, chan} = Channel.open(conn)
    :ok = Queue.bind(chan, @queue, @exchange)

    # Register the GenServer process as a consumer
    {:ok, _consumer_tag} = Basic.consume(chan, @queue)
    {:ok, chan}
  end

  # Confirmation sent by the broker after registering this process as a consumer
  def handle_info({:basic_consume_ok, %{consumer_tag: _consumer_tag}}, chan) do
    {:noreply, chan}
  end

  def handle_info(
        {:basic_deliver, payload, %{delivery_tag: tag, redelivered: _redelivered}},
        chan
      ) do
    _pid =
      spawn(fn ->
        TxWrapper.wrap(payload)
        |> TxDashboard.Dashboard.apply_transaction()
      end)

    :ok = Basic.ack(chan, tag)
    {:noreply, chan}
  end

  # def handle_info({_ref, %TxDashboard.Dashboard.Transaction{} = _transaction}, chan) do
  #   IO.inspect(binding())
  #   {:noreply, chan}
  # end

  # def handle_info({:DOWN, _ref, :process, _pid, :normal}, chan) do
  #   IO.inspect(binding())
  #   {:noreply, chan}
  # end
end
