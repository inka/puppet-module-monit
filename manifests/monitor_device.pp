# == Class: monit::monitor_device
#
# This module configures a device to be monitored by Monit
#
# === Parameters
#
# [*ensure*]       - If the file should be enforced or not (default: present)
# [*checks*]       - Array of monit check statements
#
# === Examples
#
#  monit::monitor_device { 'rootfs':
#    path => '/',
#    checks => ['if space usage > 95% then alert'],
#  }
#
# === Authors
#
# Ingo Kampe <ingo.kampe@kreuzwerker.de>
#
# === Copyright
#
# Copyright 2013 Ingo Kampe <ingo.kampe@kreuzwerker.de>
#
define monit::monitor_device ($ensure = present, $path = '/', $checks = [], $group = $name,) {
  include monit::params

  # Template uses: $checks, $path, $start_script, $stop_script, $start_timeout, $stop_timeout, $group
  file { "${monit::params::conf_dir}/$name.conf":
    ensure  => $ensure,
    content => template('monit/device.conf.erb'),
    notify  => Service[$monit::params::monit_service],
    require => Package[$monit::params::monit_package],
  }
}
