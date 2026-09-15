# Hermes Agent Umbrel App Store

This is a community Umbrel app store containing Hermes Agent from Nous Research.

Add it in Umbrel under **App Store → Community App Stores**, or from SSH:

```sh
sudo ~/umbrel/scripts/repo add https://github.com/syntaxbube/umbrel-appstore.git
sudo ~/umbrel/scripts/repo update
sudo ~/umbrel/scripts/app install hermes-agent
```

The app tracks the latest stable Hermes release. A scheduled GitHub Action updates the
manifest version and image digest when Hermes publishes a release.

## Access model

Hermes runs with host networking, `privileged: true`, host PID/IPC namespaces, the host
root filesystem mounted at `/host`, and the Docker socket. This is root-equivalent access
to the Umbrel machine. It is intentional for this app, but it means the agent can read,
change, or delete anything the host can access. Keep the dashboard behind its generated
password and do not expose the machine directly to the public Internet.

The dashboard is at `http://umbrel.local:9119`; the gateway API listens on `8642`.

## Restore a Hermes backup

Before the first launch, place exactly one `.zip` created by `hermes backup` in:

```text
~/umbrel/app-data/hermes-agent/restore/
```

For example:

```sh
mkdir -p ~/umbrel/app-data/hermes-agent/restore
cp ~/hermes-backup-*.zip ~/umbrel/app-data/hermes-agent/restore/
```

The app imports it once before starting the gateway. Remove the zip after a successful
restore if it contains secrets. If more than one zip is present, startup stops instead of
choosing one silently.
