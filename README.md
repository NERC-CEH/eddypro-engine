# eddypro-engine-image

Minimal Docker image containing the LI-COR EddyPro engine binaries:

- `eddypro_rp` (raw processing)
- `eddypro_fcc` (flux correction chain)

## Local build

```bash
docker build -t eddypro-engine:0.1.0 .
docker run --rm eddypro-engine:0.1.0 eddypro_rp --help
docker run --rm eddypro-engine:0.1.0 eddypro_fcc --help
```

## Engine version

This image is pinned to `LI-COR-Environmental/eddypro-engine` tag `v7.0.9`.

## Publishing (ECR)

Push a git tag to publish a matching image tag to AWS ECR.

Example:

- create tag: `git tag 0.1.0`
- push tag: `git push origin 0.1.0`
- published image: `<account-id>.dkr.ecr.<region>.amazonaws.com/eddypro-engine:0.1.0`
