# Setup Syncthing
- Send anonymous usage reporting: Yes

### Configure clients connections:
- Open the server and client Syncthing web UIs
- Copy the server and client devices IDs (Actions > Show ID)
- On the server:
  - Actions>Settings
    - Device Name: SERVER_NAME
  - Delete Default Folder
    - Default Folder>Edit>Remove
  - Add Folder
    - Floder label: peer-CLIENT_NAME
    - Folder path: /var/syncthing/peers-data/CLIENT_NAME
  - Add Remote Device
    - Device ID: CLIENT_DEVICE_ID
    - Folder ID: "default" (or same Folder ID as in client syncthing conf)
    - Device Name: "CLIENT_NAME"
    - Share folders with device: "peer-CLIENT_NAME"
    - Save
- On the client:
  - Add Remote Device
    - Device ID: SERVER_DEVICE_ID
    - Device Name: SERVER_NAME
    - Share folders with device: "Default folder"
    - Save
- Wait a short while and a popup "Share Folder" will appear on the server Syncthing web UI. Accept
