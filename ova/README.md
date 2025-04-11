# Open Virtual Appliance (OVA)
An OVF package consists of several files placed in one directory. An OVF package always contains exactly one OVF descriptor (a file with extension .ovf). The OVF descriptor is an XML file which describes the packaged virtual machine; it contains the metadata for the OVF package, such as name, hardware requirements, references to the other files in the OVF package and human-readable descriptions. In addition to the OVF descriptor, the OVF package will typically contain one or more disk images, and optionally certificate files and other auxiliary files.[6]

The entire directory can be distributed as an Open Virtual Appliance (OVA) package, which is a tar archive file with the OVF directory inside.

https://en.wikipedia.org/wiki/Open_Virtualization_Format

## Useful commands

**Extract `ova` file archive**:
```bash
tar -xvf <ova_file>.ova
```

**Re-calculate checksum**:
```bash
sha256sum image.ovf image.vmdk | awk '{ print "SHA256(" $2 ")= " $1 }' > image.mf
```

**Repackage `ova` file**:

The file order is important. The `image.ovf` file must be first, followed by the `image.vmdk` file, and finally the `image.mf` file. The command below will create a new OVA file with the specified name.

```bash
tar -cvf <ova_file>.ova image.ovf image.vmdk image.mf

# or, enforce POSIX-compatible format
tar -cvf <ova_file>.ova --format=ustar image.ovf image.vmdk image.mf

# --format=ustar format stands for "Uniform Standard Tape ARchive", which is a POSIX.1-compliant tar format. It ensures a certain level of portability and compatibility across different systems and applications that read tar archives.
```

## Cloud-init properties

Add the following properties as a child of `<VirtualSystem>` in the `image.ovf` file. This will allow you to customize the instance via the `cloud-init` package.

> [!IMPORTANT]
> The `cloud-init` packages is required to be installed in the image.

```xml
<ProductSection ovf:required="false">
  <Info>Cloud-Init customization</Info>
  <Product>Ubuntu 24.04 Server (20250327)</Product>
  <Property ovf:userConfigurable="true" ovf:value="id-ovf" ovf:type="string" ovf:key="instance-id">
    <Label>A Unique Instance ID for this instance</Label>
    <Description>Specifies the instance id.  This is required and used to determine if the machine should take "first boot" actions</Description>
  </Property>
  <Property ovf:userConfigurable="true" ovf:value="ubuntuguest" ovf:type="string" ovf:key="hostname">
    <Description>Specifies the hostname for the appliance</Description>
  </Property>
  <Property ovf:userConfigurable="true" ovf:type="string" ovf:key="seedfrom">
    <Label>Url to seed instance data from</Label>
    <Description>This field is optional, but indicates that the instance should 'seed' user-data and meta-data from the given url.  If set to 'http://tinyurl.com/sm-' is given, meta-data will be pulled from http://tinyurl.com/sm-meta-data and user-data from http://tinyurl.com/sm-user-data.  Leave this empty if you do not want to seed from a url.</Description>
  </Property>
  <Property ovf:userConfigurable="true" ovf:type="string" ovf:key="public-keys">
    <Label>ssh public keys</Label>
    <Description>This field is optional, but indicates that the instance should populate the default user's 'authorized_keys' with this value</Description>
  </Property>
  <Property ovf:userConfigurable="true" ovf:type="string" ovf:key="user-data">
    <Label>Encoded user-data</Label>
    <Description>In order to fit into a xml attribute, this value is base64 encoded . It will be decoded, and then processed normally as user-data.</Description>
  </Property>
  <Property ovf:userConfigurable="true" ovf:type="string" ovf:key="password">
    <Label>Default User's password</Label>
    <Description>If set, the default user's password will be set to this value to allow password based login.  The password will be good for only a single login.  If set to the string 'RANDOM' then a random password will be generated, and written to the console.</Description>
  </Property>
</ProductSection>
```

See [example.ovf](example.ovf) for a complete example.
