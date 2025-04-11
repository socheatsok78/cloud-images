# RHEL Custom Repositories

View all repositories within your organization.

![custom-repositories-1.png](./assets/custom-repositories-1.png)

**Table of contents**:
- [RHEL Custom Repositories](#rhel-custom-repositories)
  - [Essential custom repositories](#essential-custom-repositories)
  - [Adding EPEL repository](#adding-epel-repository)
  - [Using custom repositories with Image Builder](#using-custom-repositories-with-image-builder)
  - [Extra Packages for Enterprise Linux (EPEL)](#extra-packages-for-enterprise-linux-epel)
    - [EPEL 8 Everything aarch64](#epel-8-everything-aarch64)
    - [EPEL 9 Everything aarch64](#epel-9-everything-aarch64)

## Essential custom repositories
Here are some essential custom repositories that you might want to add to your RHEL system:

- [Fedora EPEL](https://fedoraproject.org/wiki/EPEL) - Extra Packages for Enterprise Linux
- [Docker CE](./docker-ce.md)

> [!NOTE]
> Please note that the repositories listed here are not exhaustive. You can add any repository that you need for your specific use case.

## Adding EPEL repository

To add the EPEL repository, please follow the steps below:

1. In the "**Red Hat Hybrid Cloud Console**", click on "View all services" and locate "Repositores" under the "Observability and Monitoring" section.
![redhat-cloud-console-0.png](./assets/redhat-cloud-console-0.png)
2. In the "**Repositories**" page, you will see a list of all repositories within your organization. (if you have any)
![custom-repositories-1.png](./assets/custom-repositories-1.png)
3. Click on the "Popular repositories" tab.
![custom-repositories-2.png](./assets/custom-repositories-2.png)
4. In the "**Popular repositories**" tab, you will see a list of popular repositories, including the EPEL repository.
5. Select the repository you want to add and click on the "Add" button.
![custom-repositories-3.png](./assets/custom-repositories-3.png)
6. Navigate to "**Your repositories**" tab to see the added repository.
![custom-repositories-4.png](./assets/custom-repositories-4.png)

## Using custom repositories with Image Builder

In the "Custom repositores" step you can select the repositories you want to use for your image.
![docker-ce-1.png](./assets/docker-ce-1.png)

Once added, you will be able to search and add packages from the custom repositories in the "Additional packages" step.
![docker-ce-2.png](./assets/docker-ce-2.png)

Select the packages you want to add to your image.
![docker-ce-3.png](./assets/docker-ce-3.png)

## Extra Packages for Enterprise Linux (EPEL)

There additional EPEL for `aarch64` architecture. The `x86_64` architecture is already available in the "Popular repositories" tab. If you want to add the `aarch64` architecture, you need to add it manually.

### EPEL 8 Everything aarch64
- Name: `EPEL 8 Everything aarch64`
- Repository type: `Introspect only`
- URL: `https://dl.fedoraproject.org/pub/epel/8/Everything/aarch64/`
- Restrict architecture: `aarch64`
- Restrict OS version: `el8`
- Modularity filtering enabled: `true`
- GPG key: `https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-8`

### EPEL 9 Everything aarch64
- Name: `EPEL 9 Everything aarch64`
- Repository type: `Introspect only`
- URL: `https://dl.fedoraproject.org/pub/epel/9/Everything/aarch64/`
- Restrict architecture: `aarch64`
- Restrict OS version: `el9`
- Modularity filtering enabled: `true`
- GPG key: `https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-9`
