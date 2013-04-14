# == Class: monit::monitor_system
#
# This module configures a service to be monitored by Monit
#
# === Parameters
#
# [*ensure*]       - If the file should be enforced or not (default: present)
# [*checks*]       - Array of monit check statements
#
# === Examples
#
#  monit::monitor_system { 'system-watch':
#    checks => ['if loadavg(1min) > 4 for 18 cycles then alert'],
#  }
#
# === Authors
#
# Eivind Uggedal <eivind@uggedal.com>
# Jonathan Thurman <jthurman@newrelic.com>
#
# === Copyright
#
# Copyright 2011 Eivind Uggedal <eivind@uggedal.com>
#
define monit::monitor_system (
  $ensure        = present,
  $checks        = [ ],
  $group         = $name,
) {
  include monit::params

  # Template uses: $pidfile, $ip_port, $socket, $checks, $start_script, $stop_script, $start_timeout, $stop_timeout, $group
  file { "${monit::params::conf_dir}/$name.conf":
    ensure  => $ensure,
    content => template('monit/system.conf.erb'),
    notify  => Service[$monit::params::monit_service],
    require => Package[$monit::params::monit_package],
  }
}
