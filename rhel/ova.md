# Open Virtual Appliance (OVA) customization for RHEL

By default, the OVA file provided by the Red Hat Insignts's Image Builder does not include the `vApp Options` or `cloud-init` properties. This document describes how to add these options to the OVA file.

You need to perform the following steps:
1. **Extract the OVA file**: The OVA file is a tar archive that contains the OVF and VMDK files. You can extract it using the `tar` command.
2. **Modify the OVF file**: The OVF file is an XML file that describes the virtual machine. You need to add the `vApp Options` and `cloud-init` properties to this file.
3. **Repack the OVA file**: After modifying the OVF file, you need to repack the OVA file using the `tar` command.
4. **Import the OVA file**: Finally, you can import the modified OVA file into your virtualization platform (e.g., VMware, VirtualBox).

### Network selection properties

This enable you to select the network that the VM will use when it is powered on during the OVA deployment.

```xml
<Envelope xmlns="...">
  <!-- ... -->
  <NetworkSection>
    <Info>The list of logical networks</Info>
    <Network ovf:name="VM Network">
      <Description>The VM Network network</Description>
    </Network>
  </NetworkSection>
  <VirtualSystem ovf:id="image">
    <!-- ... -->
    <VirtualHardwareSection ovf:transport="com.vmware.guestInfo">
      <Info>Virtual hardware requirements</Info>
      <!-- ... -->
      <Item>
        <rasd:AddressOnParent>7</rasd:AddressOnParent>
        <rasd:AutomaticAllocation>true</rasd:AutomaticAllocation>
        <rasd:Connection>VM Network</rasd:Connection>
        <rasd:Description>VmxNet3 ethernet adapter on "VM Network"</rasd:Description>
        <rasd:ElementName>Ethernet 1</rasd:ElementName>
        <rasd:InstanceID>6</rasd:InstanceID>
        <rasd:ResourceSubType>VmxNet3</rasd:ResourceSubType>
        <rasd:ResourceType>10</rasd:ResourceType>
        <vmw:Config ovf:required="false" vmw:key="wakeOnLanEnabled" vmw:value="true"/>
      </Item>
      <!-- ... -->
    </VirtualHardwareSection>
  </VirtualSystem>
</Envelope>
```


## Cloud-init properties

Add the following properties as a child of `<VirtualSystem>` in the `image.ovf` file. This will allow you to customize the instance via the `cloud-init` package.

> [!IMPORTANT]
> The `cloud-init` packages is required to be installed in the image.

```xml
<ProductSection ovf:required="false">
  <Info>Cloud-Init customization</Info>
  <!-- Uncomment and modify this following line -->
  <!-- <Product>Red Hat Enterprise Linux [version]</Product> -->
  <Property ovf:userConfigurable="true" ovf:value="id-ovf" ovf:type="string" ovf:key="instance-id">
    <Label>A Unique Instance ID for this instance</Label>
    <Description>Specifies the instance id.  This is required and used to determine if the machine should take "first boot" actions</Description>
  </Property>
  <Property ovf:userConfigurable="true" ovf:value="rhelguest" ovf:type="string" ovf:key="hostname">
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

See [example.ovf](../ova/example.ovf) for a complete example.
