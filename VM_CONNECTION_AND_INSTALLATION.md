# Connecting to Chatwoot VM & Installation Overview

This document outlines the steps taken to locate, connect to, and verify the Chatwoot installation on the Google Cloud VM.

## 1. Prerequisites

Ensure the Google Cloud CLI (`gcloud`) is installed and authenticated.

```bash
gcloud --version
```

## 2. Project Configuration

The VM resides in the `gomake-massaging-hub` project.

1.  **List available projects:**
    ```bash
    gcloud projects list
    ```

2.  **Switch to the correct project:**
    ```bash
    gcloud config set project gomake-massaging-hub
    ```

## 3. Locating the VM

List the compute instances in the project to find the target VM.

```bash
gcloud compute instances list
```

**Target Found:**
- **Name:** `chatwoot-vm`
- **Zone:** `us-central1-a`
- **Status:** `RUNNING`
- **External IP:** `34.132.7.209`

## 4. Connecting to the VM

Connect to the instance using SSH.

```bash
gcloud compute ssh chatwoot-vm --zone us-central1-a
```

*Note: This logs you in as your GCP user (e.g., `omarsabbah`).*

## 5. Installation Verification

Once connected, the Chatwoot installation was verified with the following details:

### Service Status
Checked running systemd services for Chatwoot components:

```bash
sudo systemctl list-units | grep chatwoot
```

**Active Services:**
- `chatwoot-web.1.service` (Web Application)
- `chatwoot-worker.1.service` (Background Worker)
- `chatwoot.target`

### File System & User
- **System User:** `chatwoot` (uid=1003)
- **Installation Directory:** `/home/chatwoot/chatwoot/`

### Version Check
The installed version was confirmed by reading the version file:

```bash
cat /home/chatwoot/chatwoot/VERSION_CW
```

**Current Version:** `4.4.0`

### Directory Structure
The installation follows a standard Ruby on Rails application structure located at `/home/chatwoot/chatwoot/`:

- `app/`: Application code (Models, Views, Controllers)
- `config/`: Configuration files (Database, Environment)
- `db/`: Database schema and seeds
- `public/`: Static files
- `Gemfile`: Ruby dependencies
- `package.json`: Node.js dependencies
