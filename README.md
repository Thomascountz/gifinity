# gifinity
A barebones giphy client for experiementing with devops

### Depoloyment with Ansible

Requirements:
1. You can `ssh` into the server as a non-root sudo-user
2. You have the proper `dotenv` file saved as `.env` in the root directory
3. You have the Ansible vault password

#### Bootstraping a Bare-metal Server from a New Control Machine

1. Open `ansible/bootstrap.yml` and uncomment & update the line to specify your remote username:

```yml
# Uncomment the following line to ssh into a specific user
# The user must be a non-root sudo-user
# remote-user: <<USERNAME>>
```

Change it like so:

```yml
remote-user: thomascountz
```

2. Run the following command on your control machine:

```bash
ansible-playbook master_playbook.yml -K --ask-vault-pass
```
 _If your remote user is a passwordless sudo user, leave off the `-K` flag._
 
Follow the prompts for entering your sudo password and the Ansible vault password.


#### Deploying Changes 
1. Run the following command:

```bash
ansible-playbook deploy.yml
```

After the command is finished, you should be fully deployed.

