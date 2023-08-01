<p align="center">
    <img src="https://writefreely.org/img/writefreely.svg" width="350px" alt="WriteFreely" />
</p>

WriteFreely is a clean, minimalist publishing platform made for writers. Start a blog, share knowledge within your organization, or build a community around the shared act of writing.

---

This repository's goal is to provide an easy way to deploy WriteFreely using docker.
It currently build's a docker image and publishes it to [GitHub Packages](https://github.com/kymppi/writefreely-docker/pkgs/container/writefreely-docker).

## Tags

- `latest` - latest writefreely release
- `<version number>` - specific writefreely release (e.g. `v0.13.1`)

## Usage

### File locations

- `/data` - WriteFreely data directory
- `/config/config.ini` - WriteFreely configuration file (you need to provide this)
- `/writefreely` - Everything else (WriteFreely binary, templates, static files, etc.)

## Support

If you have any questions or issues with this repository, please contact me at [me@midka.dev](mailto:me@midka.dev) or in Fediverse: [@midka@mementomori.social](https://mementomori.social/@midka).
