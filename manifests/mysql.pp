# Installs the ruby mysql client library required by some scout plugins
class scout::mysql {
  # Install ruby mysql library using mysql module.
  include mysql::client::ruby
}
