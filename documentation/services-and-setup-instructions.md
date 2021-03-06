Bellow is the list of instaled services and their manual configurations (if required).


## Misc apps / tools
|             Service             |      Access Url      |                       Implementation service name                      |                        Post-install setup instructions                       |
|:-------------------------------:|:--------------------:|:----------------------------------------------------------------------:|:----------------------------------------------------------------------------:|
|            Dashboard            |   dashboard.DOMAIN   |        [Dashmachine](https://github.com/rmountjoy92/DashMachine)       |         Nothing to configure (embeded credentials are "admin/admin")         |
|       Finances management       |    firefly.DOMAIN    |        [Firefly-iii](https://github.com/firefly-iii/firefly-iii)       |    [Instructions](../components/finances-management/setup-instructions.md)   |
|          Smart home hub         | homeassistant.DOMAIN |        [Home assistant](https://github.com/home-assistant/core)        |        [Instructions](../components/smart-home/setup-instructions.md)        |
|        Passwords manager        |   bitwarden.DOMAIN   |       [Bitwarden_rs](https://github.com/dani-garcia/bitwarden_rs)      |     [Instructions](../components/password-manager/setup-instructions.md)     |
|    Web file browser (private)   |  filebrowser.DOMAIN  |        [Filebrowser](https://github.com/filebrowser/filebrowser)       | [Instructions](../components/file-browser-web/setup-instructions/private.md) |
|    Web file browser (public)    |     share.DOMAIN     |        [Filebrowser](https://github.com/filebrowser/filebrowser)       |  [Instructions](../components/file-browser-web/setup-instructions/public.md) |
|   Files synchronisation/backup  |   syncthing.DOMAIN   |           [Syncthing](https://github.com/syncthing/syncthing)          |   [Instructions](../components/file-synchronization/setup-instructions.md)   |
|    Data manipulation toolbox    |   cyberchef.DOMAIN   |             [Cyberchef](https://github.com/gchq/CyberChef)             |                             Nothing to configure                             |
|  Privacy friendly search engine |   whoogle.DOMAIN     |      [Whoogle-search](https://github.com/benbusby/whoogle-search)      |                             Nothing to configure                             |


## Media
|             Service             |      Access Url      |                       Implementation service name                      |                        Post-install setup instructions                       |
|:-------------------------------:|:--------------------:|:----------------------------------------------------------------------:|:----------------------------------------------------------------------------:|
|           Media server          |    jellyfin.DOMAIN   |            [Jellyfin](https://github.com/jellyfin/jellyfin)            |    [Instructions](../components/media-server/setup-instructions/public.md)   |
|       Private media server      |    pellyfin.DOMAIN   |            [Jellyfin](https://github.com/jellyfin/jellyfin)            |   [Instructions](../components/media-server/setup-instructions/private.md)   |

## PVR
|             Service             |      Access Url      |                       Implementation service name                      |                        Post-install setup instructions                       |
|:-------------------------------:|:--------------------:|:----------------------------------------------------------------------:|:----------------------------------------------------------------------------:|
|     Media request interface     |      ombi.DOMAIN     |                [Ombi](https://github.com/tidusjar/Ombi)                |         [Instructions](../components/pvr/setup-instructions/ombi.md)         |
|            Movies PVR           |     radarr.DOMAIN    |               [Radarr](https://github.com/Radarr/Radarr)               |        [Instructions](../components/pvr/setup-instructions/radarr.md)        |
|           TV shows PVR          |     sonarr.DOMAIN    |               [Sonarr](https://github.com/Sonarr/Sonarr)               |        [Instructions](../components/pvr/setup-instructions/sonarr.md)        |
|    Subtitles auto-downloader    |     bazarr.DOMAIN    |            [Bazarr](https://github.com/morpheus65535/bazarr)           |        [Instructions](../components/pvr/setup-instructions/bazarr.md)        |
|            Music PVR            |     lidarr.DOMAIN    |               [Lidarr](https://github.com/lidarr/Lidarr)               |        [Instructions](../components/pvr/setup-instructions/lidarr.md)        |
|        Youtube videos PVR       |   youtubedl.DOMAIN   | [YoutubeDL-Material](https://github.com/Tzahi12345/YoutubeDL-Material) |       [Instructions](../components/pvr/setup-instructions/youtubedl.md)      |

## Automated downloads
|             Service             |      Access Url      |                       Implementation service name                      |                        Post-install setup instructions                       |
|:-------------------------------:|:--------------------:|:----------------------------------------------------------------------:|:----------------------------------------------------------------------------:|
|   Torrents tackers aggregator   |    jackett.DOMAIN    |              [Jackett](https://github.com/Jackett/Jackett)             |    [Instructions](../components/torrenting/setup-instructions/jackett.md)    |
|        Torrenting client        |  transmission.DOMAIN |      [Transmission](https://github.com/transmission/transmission)      |                             Nothing to configure                             |


## Technical services
|             Service             |      Access Url      |                       Implementation service name                      |                        Post-install setup instructions                       |
|:-------------------------------:|:--------------------:|:----------------------------------------------------------------------:|:----------------------------------------------------------------------------:|
|      Authentication gateway     |      auth.DOMAIN     |            [Authelia](https://github.com/authelia/authelia)            |                             Nothing to configure                             |
|       Notifications server      | notifications.DOMAIN |               [Gotify](https://github.com/gotify/server)               |       [Instructions](../components/notifications/setup-instructions.md)      |
|   (adds blocking) DNS Servier   |     pihole.DOMAIN    |              [Pi-hole](https://github.com/pi-hole/pi-hole)             |                             Nothing to configure                             |


## Monitoring / maintenance
|             Service             |      Access Url      |                       Implementation service name                      |                        Post-install setup instructions                       |
|:-------------------------------:|:--------------------:|:----------------------------------------------------------------------:|:----------------------------------------------------------------------------:|
| Logs aggregation & manipulation |     kibana.DOMAIN    |       [Elastic stack (formerly ELK)](https://github.com/elastic)       |  [Instructions](../components/logging/elastic-stack/setup-instructions.md)   |
|  Docker containers logs viewer  |     dozzle.DOMAIN    |               [Dozzle](https://github.com/amir20/dozzle)               |                             Nothing to configure                             |
|  Docker containers maintenance  |   portainer.DOMAIN   |           [Portainer](https://github.com/portainer/portainer)          |     [Instructions](../components/docker/setup-instructions/portainer.md)     |
|        System monitoring        |    netdata.DOMAIN    |              [Netdata](https://github.com/netdata/netdata)             |                             Nothing to configure                             |
|          Reverse proxy          |    traefik.DOMAIN    |            [Traefik](https://github.com/containous/traefik)            |                             Nothing to configure                             |
|  Remote backups of server data  |   duplicati.DOMAIN   |          [Duplicati](https://github.com/duplicati/duplicati)           |      [Instructions](../components/remote-backups/setup-instructions.md)      |

- Some docker images will be automatically updated by [Watchtower](https://github.com/containrrr/watchtower). It does not have a web interface, but you can find setup instructions [here](../components/docker/setup-instructions/watchtower.md).
