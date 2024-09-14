import gleam/erlang/process
import koyori/router
import mist
import wisp
import wisp/wisp_mist

const koyori_port = 2811

pub fn main() {
  wisp.configure_logger()

  let secret_key_base = wisp.random_string(64)

  // Start the Mist web server.
  let assert Ok(_) =
    wisp_mist.handler(router.handle_request, secret_key_base)
    |> mist.new
    |> mist.port(koyori_port)
    |> mist.start_http

  // The web server runs in new Erlang process, so put this one to sleep while
  // it works concurrently.
  process.sleep_forever()
}
