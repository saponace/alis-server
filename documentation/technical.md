# Technical documentation

The following table represents the authentication means for all services:

|       Embeded      | Jellyfin auth (embeded with periodic jellyfin user db import) | Authelia + embeded (admin access) |    Authelia SSO    |
|:------------------:|:-------------------------------------------------------------:|:---------------------------------:|:------------------:|
|       Gotify       |                              Ombi                             |           Homeassistant           | All other services |
|      Bitwarden     |                                                               |            Filebrowser            |                    |
| Filebrowser-public |                                                               |                                   |                    |
|      Jellyfin      |                                                               |                                   |                    |
|      Pellyfin      |                                                               |                                   |                    |
|       Firefly      |                                                               |                                   |                    |

The services that expose a web-UI and are not mentionned in this table require authentication with Authelia
