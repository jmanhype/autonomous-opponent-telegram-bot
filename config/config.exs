# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

import Config

# Configure ExGram and Tesla adapter
config :ex_gram,
  adapter: ExGram.Adapter.Tesla

# Configure Tesla to use Hackney adapter
config :tesla,
  adapter: Tesla.Adapter.Hackney

# Configure JSON engine
config :jason,
  escape_forward_slashes: false

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"