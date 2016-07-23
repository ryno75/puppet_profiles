# Class: profiles::jamwiki
# ===========================
#
# Installs and configures jamwiki
#
class profiles::jamwiki {
  include nginx
  include tomcat
  include jamwiki
}
