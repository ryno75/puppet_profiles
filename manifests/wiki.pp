# Class: profiles::jamwiki
# ===========================
#
# Installs and configures jamwiki
#
class profiles::wiki {
  include nginx
  include tomcat
  include jamwiki
}
