use Mix.Config

# Configure your database
config :yinxing_e, YinxingE.Repo,
  username: "postgres",
  password: "postgres",
  database: "yinxing_e_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Configure your database
config :yinxing_e, YinxingE.Repo,
  username: "postgres",
  password: "postgres",
  database: "yinxing_e_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Configure your database
config :yinxing_e, YinxingE.Repo,
  username: "postgres",
  password: "postgres",
  database: "yinxing_e_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :yinxing_e, YinxingEWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
