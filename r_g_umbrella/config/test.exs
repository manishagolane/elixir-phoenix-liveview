import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :top_pack, TopPack.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "LfrK+Pn5Lu5Y16k9zZs6IxSHjbIQILb09BnfPK0D/WcXZ7jE2HCdRCyM/wzKZuKG",
  server: false
