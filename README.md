# Boxen SSH Configuration 

### Installs:
- ssh-copy-id
- sshpass 1.05

### Configures:
- If modules/people/files/<github username>/ssh_config exists, it will be moved into place
- Creates a new rsa key if one does not exist
- Sets up key-authentication to all the hosts in your config file


### Usage:

```
include sshconfig
```

Users can add their configuration files in modules/people/files/<github username>/ssh_config


Insert the following in the bootstrap shell script for boxen.

```
echo "Enter network password:"
read -s SSHPASS

echo $SSHPASS > /tmp/mp
chmod 700 /tmp/mp
```

### Required Puppet Modules

* `boxen`