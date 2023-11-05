# Data Tier

## Database

The database operates on a VM. In this case, a DigitalOcean Droplet.

The choice of database is EdgeDB.

### 1. Setup Droplet

### 3. Enter Credentials

Ensure Droplet credentials are entered in `./env.local` environment file,
this file will be used by `./deploy.sh` to upload a script that will setup the server
along with prerequisite files.

### 2. Secure Communication of Local<->Docker Comms

To create SSH keys for secure file transfers using `scp`, you can use the `ssh-keygen` command. Here's how you can generate SSH keys:

1. **Open a Terminal or Command Prompt:**

   Open a terminal window on your local machine. This process will generate the keys locally.

2. **Generate SSH Keys:**

   Run the following command to generate an SSH key pair:

   ```bash
   ssh-keygen -t rsa -b 2048
   ```

   This command generates a 2048-bit RSA key pair. You can also use the `-t` option to specify a different type of key (e.g., `ed25519`) and the `-b` option to specify the number of bits in the key (e.g., `4096`).

   During the process, you'll be prompted to provide a location to save the generated keys. Press Enter to save them in the default location (`/home/your_username/.ssh/id_rsa` on Linux/Mac or `C:\Users\your_username\.ssh\id_rsa` on Windows) or provide a different location if you prefer.

3. **Set a Passphrase (Optional but Recommended):**

   You can set a passphrase for an extra layer of security. If someone gains access to your private key, they would still need the passphrase to use it. After generating the keys, you'll be prompted to enter a passphrase.

4. **Copy the Public Key to the Remote Server:**

   After generating the keys, you need to copy the public key (`id_rsa.pub`) to the remote server. You can use `ssh-copy-id` or manually copy the contents of the public key file and add them to the `~/.ssh/authorized_keys` file on the remote server.

   To use `ssh-copy-id`, run:

   ```bash
   ssh-copy-id username@remote_host
   ```

   Replace `username` with your remote username and `remote_host` with the IP address or hostname of the remote server. You'll be prompted to enter your password on the remote server. Once the public key is copied, you can use `scp` without being prompted for a password.

   If you prefer to manually copy the public key, you can use a text editor to open the `id_rsa.pub` file and copy its contents. Then, log in to your remote server, navigate to the `~/.ssh` directory, and paste the public key into the `authorized_keys` file. If the `authorized_keys` file doesn't exist, you can create it.

After completing these steps, you can use `scp` without passwords, as your SSH keys will be used for authentication, providing a more secure way to transfer files between your local machine and the remote server.

## Install and Run DB

### 1. Check Server Credentials and Script

Double check the server credentials:

* `./env.server` environment file.
* Certificate (`server.crt`), private key (`server.key`), and password file (`.password`) in `./credentials` folder.

Double check the server setup script that will run in the Droplet: `./start-edgedb-server.sh`

### 2. Run the Deploy Script

Run the deploy script (`./deploy.sh`) which will upload the setup script (`./start-edgedb-server.sh`) and prerequisite files to the Droplet.

After uploading, the deploy script will automatically execute the setup script remotely on the Droplet.

The setup script will attempt to download the `EdgeDB` Docker image and run a container instance on the Droplet.

Manually log into the Droplet shell (using DigitalOcean Control Panel) to check the status of the container:

```bash
    # 1. get container hash for 'edgedb-server'
    docker container ls

    # 2. check logs of 'edgedb-server'
    docker logs <hash>
```

## Troubleshooting

### Firewall

Ensure port # 5656 is open for TCP traffic.
