# SSHConfig 
# Reads a user's ssh config file to 
#   - if specified, move the user's sshconfig file in place
#   - create the ssh key
#   - distribute it to all the servers in the user's sshconfig file
class sshconfig {
  anchor { 'Hello_World': }
}
