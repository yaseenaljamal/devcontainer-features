
# Mount PNPM Store (mount-pnpm-store)

Mounts the pnpm store to a volume to share between multiple devcontainers, and sets pnpm store to ~/.pnpm-store. Fails if pnpm is not installed.

## Example Usage

```json
"features": {
    "ghcr.io/joshuanianji/devcontainer-features/mount-pnpm-store:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|


## Important Implementation Details

### Ensuring PNPM is installed

This feature does not install PNPM by itself and expects `pnpm` to be installed already, either by a base image or by a feature. It fails quietly if pnpm is not installed.

If you are installing pnpm with a feature, you may need to ensure it is run **before** `mount-pnpm-store`. To make this work, use the [`overrideFeatureInstallOrder` property](https://containers.dev/implementors/features/#overrideFeatureInstallOrder), since the default feature installation order is based on ID (alphanumerically i think). Here is an example using `features/node`:

```json
    "image": "mcr.microsoft.com/devcontainers/base:bullseye",
    "features": {
        "ghcr.io/devcontainers/features/node:1": {
            "version": "20"
        },
        "ghcr.io/joshuanianji/devcontainer-features/mount-pnpm-store": {}
    },
    "overrideFeatureInstallOrder": [
        "ghcr.io/devcontainers/features/node", 
        "ghcr.io/joshuanianji/devcontainer-features/mount-pnpm-store"
    ]
```

### Volume Mount Naming

The volume mount is called `global-devcontainer-pnpm-store`, so ensure that no other docker volumes match this name.

## Changelog

| Version | Notes                                                |
| ------- | ---------------------------------------------------- |
| 0.0.0   | Initial Version                                      |

## References

- [PNPM Devcontainer Setup by PatrickChoDev](https://gist.github.com/PatrickChoDev/81d36159aca4dc687b8c89983e64da2e)


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/joshuanianji/devcontainer-features/blob/main/src/mount-pnpm-store/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._