# Class: profiles::wiki
# ===========================
#
# Installs and configures wiki profile
#
class profiles::wiki {

  # perform hiera lookups for tomcat:instance and nginx::resource::vhost
  # they are defined types and not a class so can't do hiera data binding

  $nginx_vhost_name  = hiera('nginx::resource::vhost::name')
  $nginx_vhost_port  = hiera('nginx::resource::vhost::listen_port')
  $nginx_vhost_proxy = hiera('nginx::resource::vhost::proxy')

  $install_from_source            = hiera('tomcat::instance::install_from_source')
  $package_name                   = hiera('tomcat::instance::package_name')
  $service_name                   = hiera('tomcat::service::service_name')
  $use_init                       = hiera('tomcat::service::use_init')
  $use_jsvc                       = hiera('tomcat::service::use_jsvc')
  $tomcat_server_additional_attrs = hiera_hash('tomcat::config::server::connector::additional_attributes')

  include nginx
  include tomcat
  nginx::resource::vhost { $nginx_vhost_name:
    listen_port => $nginx_vhost_port,
    proxy       => $nginx_vhost_proxy,
  }
  tomcat::instance { 'default':
    package_name        => $package_name,
    install_from_source => $install_from_source,
  }
  tomcat::config::server::connector { 'HTTP/1.1':
    port                  => 8080,
    additional_attributes => $tomcat_server_additional_attrs
  }
  tomcat::service { 'default':
    use_init     => true,
    use_jsvc     => false,
    service_name => $service_name,
  }
  class { 'jamwiki': 
    require => [ Class['tomcat'], Class['nginx'] ]
  }

} 
