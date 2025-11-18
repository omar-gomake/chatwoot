# Operations Guide for Chatwoot VM

This document provides instructions for common operational tasks related to the Chatwoot VM, including logging in, restarting services, and deploying code.

**IMPORTANT**: This guide uses the actual VM credentials. The values are configured for the production Chatwoot VM.

## Connecting to the VM

To connect to the Chatwoot VM, you will use the `gcloud compute ssh` command.

```bash
gcloud compute ssh chatwoot-vm --zone us-central1-a --project gomake-massaging-hub
```

## Restarting Services

Once you are connected to the VM, you can restart the Chatwoot services. The services are managed by `systemd`.

```bash
# Restart the Chatwoot web server
sudo systemctl restart chatwoot-web.1.service

# Restart the Chatwoot worker
sudo systemctl restart chatwoot-worker.1.service

# Check the status of the services
sudo systemctl status chatwoot-web.1.service
sudo systemctl status chatwoot-worker.1.service
```

## Deploying Code

To deploy new code to the VM, follow these steps:

1.  **Connect to the VM** using the `gcloud compute ssh` command as described above.

2.  **Navigate to the Chatwoot directory**. The application is typically located in `/home/chatwoot/chatwoot`.

    ```bash
    cd /home/chatwoot/chatwoot
    ```

3.  **Switch to the `chatwoot` user**.

    ```bash
    sudo -u chatwoot -i
    ```

4.  **Pull the latest code** from the `develop` branch (or your target branch).

    ```bash
    git checkout develop
    git pull origin develop
    ```

5.  **Install dependencies**.

    ```bash
    bundle install
    yarn install
    ```

6.  **Precompile assets**.

    ```bash
    rake assets:precompile
    ```

7.  **Run database migrations**.

    ```bash
    rake db:migrate
    ```

8.  **Exit the `chatwoot` user shell**.

    ```bash
    exit
    ```

9.  **Restart the Chatwoot services** as described in the "Restarting Services" section.

    ```bash
    sudo systemctl restart chatwoot-web.1.service
    sudo systemctl restart chatwoot-worker.1.service
    ```
