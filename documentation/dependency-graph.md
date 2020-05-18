# Dependency graph
Dependency graph: what services call what services
![Alt text](https://g.gravizo.com/source/custom_mark0?https://raw.githubusercontent.com/saponace/alis-server/master/documentation/dependency-graph.md)
<details>
<summary>Graph definition</summary>
custom_mark0
digraph G {

  subgraph cluster_0 {
    label = "Media center";
    style=filled;
    color=lightgrey;
    node [style=filled,color=white];

    Jellyfin;
  }

  subgraph cluster_1 {
    label = "PVR";
    style=filled;
    color=lightgrey;
    node [style=filled,color=white];

    Ombi;
    Radarr;
    Sonarr;
    Bazarr;
    Lidarr;
  }

  subgraph cluster_2 {
    label = "Torrenting";
    style=filled;
    color=lightgrey;
    node [style=filled,color=white];

    Jackett;
    Transmission;
  }

  subgraph cluster_3 {
    label = "Technical";
    style=filled;
    color=lightgrey;
    node [style=filled,color=white];

    Notifications;
  }

  subgraph cluster_4 {
    label = "Maintenance";
    style=filled;
    color=lightgrey;
    node [style=filled,color=white];

    Watchtower;
  }

  Jellyfin -> Notifications;

  Ombi -> Notifications;
  Ombi -> Jellyfin;
  Ombi -> Radarr;
  Ombi -> Sonarr;
  Ombi -> Lidarr;

  Radarr -> Notifications;
  Radarr -> Jackett;
  Radarr -> Transmission;

  Sonarr -> Notifications;
  Sonarr -> Jackett;
  Sonarr -> Transmission;

  Lidarr -> Notifications;
  Lidarr -> Jackett;
  Lidarr -> Transmission;

  Bazarr -> Notifications;
  Bazarr -> Radarr;
  Bazarr -> Sonarr;

  Watchtower -> Notifications;
}
custom_mark0
</details>
