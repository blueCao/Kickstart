# install openldap-clients sssd authconfig nss-pam-ldapd
yum localinstall pkg_download/*

# config
cp etc/sysconfig/authconfig /etc/sysconfig/authconfig 
cp etc/openldap/ldap.conf /etc/openldap/ldap.conf
cp etc/nsswitch.conf /etc/nsswitch.conf

# stop ldap authconfig
authconfig --disableldapauth --disableldap --enableshadow --updateall

# config ldap client
authconfig --enableldap --enableldapauth --ldapserver=ldap.local --ldapbasedn="dc=k8s,dc=cnic" --enablemkhomedir --update

# restart nslcd,sshd
systemctl restart nslcd
systemctl restart sshd

# show available login users
getent passwd
