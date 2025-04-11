# Red Hat Enterprise Linux (RHEL)

Everywhere enterprise IT is headed, Red Hat® Enterprise Linux® is there. From the public cloud to the edge, it evolves to bring flexibility and reliability to new frontiers.

## RHEL Cloud Images

To obtain the latest RHEL Cloud Images, you need the following:
- Red Hat account
- Access to Red Hat Cloud Console
- Access to Image Builder tool
- Blueprints for the images you want to create

Please follow this [guide](./rhel_image_builder.md) to create your own RHEL Cloud Images using the Image Builder tool.

## Using RHEL Cloud Images

Before using RHEL Cloud Images, you need to modify the OVA file to enable `cloud-init` configuration. Please follow this [guide](./rhel_ova.md) to modify the OVA file.

> [!NOTE]
> The default user for RHEL Cloud Image is `cloud-user`.
>
> The default user's password will be randomly generated if not provided via the `user-data` file.
