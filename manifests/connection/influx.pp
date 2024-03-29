# @summary Manages the connections to influx
#
# @example
#   chronograf::connection::influx { 'connection': }
define chronograf::connection::influx (
  String $connection = $title,
  Enum['present', 'absent'] $ensure = 'present',
  String $id = '10000',
  String $username = 'test',
  String $password = 'test',
  Stdlib::HTTPUrl $url = 'http://localhost:8086',
  String $type = 'influx',
  Boolean $insecure_skip_verify = false,
  Boolean $default = true,
  String $telegraf = 'telegraf',
  String $organization = 'example_org',
  String $connection_template = $chronograf::influx_connection_template,
  Stdlib::Absolutepath $resources_path = $chronograf::resources_path,
) {
  file { "${resources_path}/${connection}.src":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($connection_template),
  }
}
