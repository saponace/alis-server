# Setup Duplicati

### What it is used for
Duplicati is a backup solution that periodically backs-up one or multiple folders to the given location

Duplicati is here used to back up three folders:
- /mnt/services: server apps suite services configs and data
- /mnt/misc-data/important: Important (vital) data
- /mnt/misc-data/syncthing-data: Syncthing data (see [Syncthing configuration](../file-synchronization/setup-instructions.md))

Duplicati backs up data to three locations:
- A local folder on the server: /mnt/misc-data/duplicati-backups
- Mega.nz
- Backblaze B2: TODO
All backups (even local) are encrypted


- On the first run, when prompted if a password should be set, click "No, my machine has only a single account" (Duplicati
is protected via SSO)

### Create backups rules
- Click "Add backup"
  - Configure a new backup
    - Name: BACKUP_NAME
    - Encryption: AES-256
    - Set passphrase
    - Click "Next"
  - Destination
    - Storage type: STORAGE_TYPE
    - Folder path: FOLDER_PATH
    - Enter credentials if not a local backup
    - Click "Next"
  - Source
    - Source data: /source/
    - Click "Next"
  - Schedule
    - Automatically run backups: true
    - Next time: BACKUP_TIME, "Today"
    - Run again every "1" "Days"
    - Allowed days: Mon, Tue, Wed, Thu, Fri, Sayt, Sun
  - Options
    - General options
      - Remote volume size: "50" "MBytes"
      - Backup retentions: "Custom backup retention" "14D:1D,52W:2W,36M:1M"
      - Click "Save"

- Execute the above steps for the following options, and use values in placeholders:
  - Local backup
    - BACKUP_NAME: "Local"
    - STORAGE_TYPE: "Local folder or drive"
    - FOLDER_PATH: "/backups/"
    - BACKUP_TIME: "01:00PM"
  - Mega.nz backup
    - BACKUP_NAME: "Mega.nz"
    - STORAGE_TYPE: "mega.nz"
    - FOLDER_PATH: "/server-backup/"
    - BACKUP_TIME: "02:00PM"
  - Backblaze B2: TODO: add Backblaze B2


### Backup and restore
#### Backup
Backups are executed daily. If you wish to create a backup before the next scheduled backup, click on "Home", go to the
location you want to add a backup to, and click _Run now_
#### Restore
You will need:
  - Backup passphrase
  - file hosting account pcredentials

1. If the reverse proxy is not available (ex: drives holding traefik config crashed, etc.), add the following to the
duplicati docker-compose definitions:
```
  ports:
    - 8200:8200
```
2. Navigate either to duplicati.DOMAIN, or SERVER_LOCAL_IP:8200

3. If the duplicati configuration is intact (backups configurations saved):
Menu "Home", go to the location you want to add a backup to, and click _Restore file_.
Choose the version you want to restore and the files/folders that should be restored and follow the prompted
instructions

4. Else:
  - Menu "Restore"
  - "Direct restore from backup files"
  - Backup location
    - Storage type: Select where the backup has been saved (ex: mega.nz)
  - Encryption
    - Input backup passphrase
  - Select files
    - Choose files / folders to restore
  - Restore options
    - Where do you want to restore the files to? "/source/"
