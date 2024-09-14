import gleam/http.{Get}
import gleam/string_builder
import koyori/web
import simplifile.{read}
import wisp.{type Request, type Response}

const koyori_static_html = "./static/koyori.html"

pub fn handle_request(req: Request) -> Response {
  // Apply the middleware stack for this request/response.
  use _req <- web.middleware(req)

  case wisp.path_segments(req) {
    [] -> koyori_redirect(req)

    ["koyori"] -> koyori_home(req)

    _ -> wisp.not_found()
  }
}

fn koyori_redirect(req: Request) -> Response {
  use <- wisp.require_method(req, Get)
  wisp.redirect("/koyori")
}

fn koyori_home(req: Request) -> Response {
  use <- wisp.require_method(req, Get)

  let assert Ok(html_content) = read(from: koyori_static_html)

  let body = string_builder.from_string(html_content)

  wisp.ok()
  |> wisp.html_body(body)
}
