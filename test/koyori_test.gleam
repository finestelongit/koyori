import gleeunit
import gleeunit/should
import koyori/router
import wisp/testing

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn koyori_home_test() {
  let request = testing.get("/koyori", [])
  let response = router.handle_request(request)

  response.status
  |> should.equal(200)
}
